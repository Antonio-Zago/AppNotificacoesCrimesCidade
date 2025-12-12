
import 'package:flutter/material.dart';
import 'package:notifica_crimes_frontend/data/repositories/notifications/notification_repository.dart';

class SplashViewModel extends ChangeNotifier{

  SplashViewModel({required this.notificationRepository});

  final NotificationRepository notificationRepository;

  Exception? error;

  Future<void> initState() async {
    try {

      await Future.delayed(Duration(seconds: 5));

      await notificationRepository.initFcm();

    } on Exception catch (exception) {
      error = exception;
    } finally {
      notifyListeners();
    }
  }

  void clearError() {
    error = null;
  }
}