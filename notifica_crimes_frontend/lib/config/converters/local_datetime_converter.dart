import 'package:timezone/timezone.dart' as tz;

class LocalDateTimeConverter {
  static DateTime fromJson(String value) {
    return DateTime.parse(value).toLocal();
  }

  static String toJson(DateTime date) {
    return date.toLocal().toIso8601String();
  }
}