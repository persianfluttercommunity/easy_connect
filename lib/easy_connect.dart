library easy_connect;

import 'easy_connect.dart';

export 'src/api.dart';
export 'src/api_response.dart';
export 'src/api_request.dart';
export 'src/easy_connect_config.dart';

late EasyConnectConfig easyConnectConfig;

/// A Rest Api Connector
class EasyConnect {}

void setEasyConnectConfig(EasyConnectConfig config) {
  easyConnectConfig = config;
}
