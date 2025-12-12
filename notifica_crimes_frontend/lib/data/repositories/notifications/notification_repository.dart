

import 'package:result_dart/result_dart.dart';

abstract class NotificationRepository {
  Future<Result<void>> initFcm();
}