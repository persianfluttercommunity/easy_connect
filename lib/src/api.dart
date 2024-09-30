import 'package:dio/dio.dart';
import 'package:easy_connect/easy_connect.dart';

class Api {
  late Map<String, String> headers;

  Api(this.request, {this.inputs, this.filesTitle = 'image'});
  final ApiRequest request;
  Map<String, dynamic>? inputs;
  String filesTitle = 'image';

  final Dio _dio = Dio(BaseOptions(
    baseUrl: easyConnectConfig.url,
    connectTimeout: easyConnectConfig.timeout,
  ));

  Future<void> fillHeaders() async {
    try {
      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Access-Control-Allow-Origin': '*',
      };

      if (easyConnectConfig.token != null) {
        headers.addAll({
          'Authorization': 'Bearer ${easyConnectConfig.token}',
        });
      }
    } catch (e) {
      headers = {};
    }
  }

  Future<ApiResponse> connect({String urlParam = "", bool body = false}) async {
    await fillHeaders();
    _dio.options.headers = headers;
    _dio.options.connectTimeout = const Duration(seconds: 10);
    if (urlParam.isNotEmpty) {
      urlParam = urlParam.startsWith("/") ? urlParam : "/$urlParam";
    }
    Response? response;
    try {
      switch (request.type) {
        case RequestType.post:
          response = await _dio.post(
            request.route + urlParam,
            data: inputs,
          );
          break;
        case RequestType.get:
          response = await _dio.get(
            request.route + urlParam,
            data: inputs,
          );
          break;
        default:
          break;
      }
    } catch (e) {
      if ((e as DioException).type == DioExceptionType.connectionTimeout) {
        if (easyConnectConfig.errorHandler != null) {
          easyConnectConfig.errorHandler!(408);
        }
      } else {
        response = (e).response;
      }
    }

    if (response != null) {
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
      } else if (response.statusCode == 401) {
        if (easyConnectConfig.logout != null) {
          easyConnectConfig.logout!();
        }
      } else if (response.statusCode == 404) {
        if (easyConnectConfig.errorHandler != null) {
          easyConnectConfig.errorHandler!(404);
        }
        // Not found
      } else if (response.statusCode == 503) {
        if (easyConnectConfig.errorHandler != null) {
          easyConnectConfig.errorHandler!(500);
        }
        // Server Upgrading
      } else if (response.statusCode == 422 ||
          response.statusCode == 500 ||
          response.statusCode == 403) {
        if (easyConnectConfig.errorHandler != null) {
          easyConnectConfig.errorHandler!(response.statusCode!);
        }
        // String errorString = "";
        // var errorsJson = json.decode(res)['errors'];
        // if (errorsJson is Map) {
        //   errorsJson.forEach((key, value) {
        //     for (var element in (value as List)) {
        //       errorString += "${element as String}\n";
        //     }
        //   });
        // } else if (errorsJson is List) {
        //   for (var element in errorsJson) {
        //     for (var value in (element as List)) {
        //       errorString += "${value as String}\n";
        //     }
        //   }
        // }
        // if (errorString.isEmpty) {
        //   errorString = "Error ${response.statusCode}";
        // }
      }
    }

    return ApiResponse(response);
  }
}
