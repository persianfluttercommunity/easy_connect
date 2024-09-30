class EasyConnectConfig {
  EasyConnectConfig({
    required this.url,
    this.timeout = const Duration(seconds: 10),
    this.logout,
    this.errorHandler,
  });
  String url;
  String? token;
  Duration timeout;
  Function()? logout;
  Function(int)? errorHandler;
}
