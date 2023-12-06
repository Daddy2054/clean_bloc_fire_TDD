import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  String toFormattedString() {
    return DateFormat('hh:mm').format(this);
  }
}
