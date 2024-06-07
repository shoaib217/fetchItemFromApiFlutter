extension StringValueCheck on String {
  bool isNotNullOrEmpty() {
    return this != "" && this != "null";
  }
}
