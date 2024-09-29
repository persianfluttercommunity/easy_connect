class ApiRequest {
  ApiRequest(
      {required this.route, this.auth = true, this.type = RequestType.post});
  String route;
  bool auth;
  RequestType type;
}

enum RequestType { post, get, patch, delete }
