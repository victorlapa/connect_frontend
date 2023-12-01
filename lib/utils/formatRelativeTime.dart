import 'package:timeago/timeago.dart' as timeago;

class FormatRelativeTime {
  static String formatRelativeTime(String dateString) {
    DateTime dateTime = DateTime.parse(dateString).toLocal();
    Duration timeDifference = DateTime.now().toLocal().difference(dateTime);

    String relativeTime = timeago.format(dateTime.subtract(timeDifference));

    return relativeTime;
  }
}
