class BuildServer {
  static Uri buildUrl(String endpoint) {
    const String host = "http://14.225.207.174:8080/";
    // const String host = "http://192.168.1.21:8000/";
    final apiPath = host + endpoint;
    return Uri.parse(apiPath);
  }
}
