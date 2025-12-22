import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/data/repositories/notifications/notification_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/data/services/model/fcm_request/fcm_request_api_model.dart';
import 'package:result_dart/result_dart.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  print("Title = ${message.notification?.title}");
  print("Body = ${message.notification?.body}");
  print("Payload = ${message.data}");
}

class NotificationRepositoryRemote implements NotificationRepository {
  NotificationRepositoryRemote({
    required this.firebaseMessaging,
    required this.storage,
    required this.apiClient,
    required this.localNotifications,
  });

  final FirebaseMessaging firebaseMessaging;
  final FlutterSecureStorage storage;
  final ApiClient apiClient;
  final FlutterLocalNotificationsPlugin localNotifications;

  AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        'Notificações Importantes',
        description: 'Canal para notificações em foreground',
        importance: Importance.high,
      );

  @override
  Future<Result<void>> initFcm() async {
    try {
      var email = await storage.read(key: "email");

      if (email == null || email.isEmpty) {
        return Success(Null);
      }

      NotificationSettings permission = await firebaseMessaging
          .requestPermission();

      //Android: cria canal
      await localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(channel);

      if (permission.authorizationStatus == AuthorizationStatus.denied) {
        return Success(Null);
      }

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true, // Mostrar alerta
            badge: true, // Mostrar badge
            sound: true, // Tocar som
          );

      final fcm = await firebaseMessaging.getToken();

      print("fcm = $fcm");

      await storage.write(key: 'fcm', value: fcm);

      var request = FcmRequestApiModel(email: email, tokenFcm: fcm!);

      var retorno = await apiClient.postFcm(request);

      retorno.getOrThrow();

      FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;

        if (notification == null) return;

        localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      });

      FirebaseMessaging.instance.onTokenRefresh
          .listen((fcmToken) async {
            await storage.write(key: 'fcm', value: fcmToken);

            var retorno = await apiClient.postFcm(request);

            retorno.getOrThrow();
          })
          .onError((err) {
            return Failure(Exception(err));
          });
      return Success(Null);
    } on Exception catch (exception) {
      return Failure(Exception(exception));
    }
  }
}
