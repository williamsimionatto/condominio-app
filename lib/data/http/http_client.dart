abstract class HttpClient {
  Future<Map>? request(
      {required String url, required String method, Map? body});
}
