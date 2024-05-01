import 'package:dio/dio.dart';


class HeadersInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers["accept"] = "application/json";
    options.headers["Accept-language"] = 'pt-br';

 

    return handler.next(options);
  }
}
