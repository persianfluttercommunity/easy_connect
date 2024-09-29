import 'dart:convert';

import 'package:dio/dio.dart';

class ApiResponse {
  ApiResponse(this.response) {
    try {
      content = _jsonContent();
    } catch (e) {
      content = {};
    }
  }
  Response? response;
  late Map<String, dynamic> content;

  bool success() {
    return content.containsKey("status") && content["status"] == "success";
  }

  String message() {
    if (content.containsKey("message")) {
      return content["message"];
    }
    if (content.containsKey("content")) {
      return content["content"];
    }
    return "خطای نامشخص";
  }

  Map<String, dynamic> _jsonContent() {
    try {
      if (response!.data is Map) {
        return response!.data;
      } else {
        var result = json.decode(response!.data);
        return result;
      }
    } catch (e) {
      return {};
    }
  }
}
