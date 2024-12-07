class UserClientPath {
  static Uri ranking(int month) {
    return Uri.parse("http://192.168.86.176/stats/ranking?month=$month");
  }

  static Uri time() {
    return Uri.parse("http://192.168.86.176/stats/time?month=4");
  }

  static Uri measurements() {
    return Uri.parse("http://192.168.86.176/measurements/?page=0&size=1");
  }
}
