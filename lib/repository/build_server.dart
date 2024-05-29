class BuildServer {
  static Uri buildUrl(String endpoint) {
    const String host = "http://10.0.2.2:8080/";
    // const String host = "http://192.168.1.21:8000/";
    final apiPath = host + endpoint;
    return Uri.parse(apiPath);
  }
}
