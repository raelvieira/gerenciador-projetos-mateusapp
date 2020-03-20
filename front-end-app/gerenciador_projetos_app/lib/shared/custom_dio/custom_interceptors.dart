import 'dart:io';

import 'package:dio/dio.dart';

class CustomInterceptors extends InterceptorsWrapper {

  @override
  Future onRequest(RequestOptions options) {
    options.contentType = ContentType.parse('application/json;charset=UTF-8');
  }

  @override
  Future onError(DioError error) { }

  @override
  Future onResponse(Response response) { }
}