import 'package:dio/dio.dart';

import 'custom_interceptors.dart';

class CustomDio extends Dio {
  CustomDio() {
    options.baseUrl = 'http://10.0.2.2:8080/';
    interceptors.add(CustomInterceptors());
    options.connectTimeout = 10000;
  }
}