String timeAgoFromIso(String isoString) {
  DateTime pastTime = DateTime.parse(isoString);

  Duration difference = DateTime.now().difference(pastTime);

  int seconds = difference.inSeconds;
  int minutes = difference.inMinutes;
  int hours = difference.inHours;
  int days = difference.inDays;
  int months = difference.inDays ~/ 30;
  int years = difference.inDays ~/ 365;

  if (seconds < 60) {
    return '$seconds detik yang lalu';
  } else if (minutes < 60) {
    return '$minutes menit yang lalu';
  } else if (hours < 24) {
    return '$hours jam yang lalu';
  } else if (days < 30) {
    return '$days hari yang lalu';
  } else if (months < 12) {
    return '$months bulan yang lalu';
  } else {
    return '$years tahun yang lalu';
  }
}
