bool isUrlPresent(String text) {
  final urlRegex = RegExp(r"(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+",
      caseSensitive: false, multiLine: true);
  return urlRegex.hasMatch(text);
}
