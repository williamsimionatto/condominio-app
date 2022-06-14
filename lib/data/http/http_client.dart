abstract class HttpClient<ResponseType> {
  Future<ResponseType>? request(
      {required String url, required String method, Map? body});
}
