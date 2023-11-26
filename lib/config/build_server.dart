class BuildServer {
  static Uri buildUrl(String endpoint) {
    const String host = "http://14.225.207.174:8080/api/";
    final apiPath = host + endpoint;
    return Uri.parse(apiPath);
  }
}
