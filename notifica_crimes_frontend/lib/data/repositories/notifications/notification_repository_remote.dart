import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:notifica_crimes_frontend/data/repositories/notifications/notification_repository.dart';
import 'package:notifica_crimes_frontend/data/services/api/api_client.dart';
import 'package:notifica_crimes_frontend/data/services/model/fcm_request/fcm_request_api_model.dart';
import 'package:result_dart/result_dart.dart';


Future<void> onBackgroundMessage(RemoteMessage message) async{
  print("Title = ${message.notification?.title}");
  print("Body = ${message.notification?.body}");
  print("Payload = ${message.data}");
}

class NotificationRepositoryRemote implements NotificationRepository {
  NotificationRepositoryRemote({
    required this.firebaseMessaging,
    required this.storage,
    required this.apiClient,
  });

  final FirebaseMessaging firebaseMessaging;
  final FlutterSecureStorage storage;
  final ApiClient apiClient;

  @override
  Future<Result<void>> initFcm() async {
    try {

      var email = await storage.read(key: "email");

      if(email == null || email.isEmpty){
        return Success(Null);
      }

      NotificationSettings permission = await firebaseMessaging
          .requestPermission();

      if (permission.authorizationStatus == AuthorizationStatus.denied) {
        return Success(Null);
      }

      final fcm = await firebaseMessaging.getToken();

      print("fcm = $fcm");

      await storage.write(key: 'fcm', value: fcm);

      var request = FcmRequestApiModel(email: email, tokenFcm: fcm!);

      var retorno = await apiClient.postFcm(request);

      retorno.getOrThrow();

      FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        //Quando o app está fechado
        print("onMessage: " + message.notification!.title!);
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
