import 'package:flut_base_app_razzies/core/services/client_https/base/base_string_helper.dart';
import 'package:flut_base_app_razzies/core/services/client_https/base/client_base_impl.dart';
import 'package:dio/dio.dart';

class ClientHttps extends ClientHttpsBaseImpl {
  ClientHttps({
    super.interceptors,
    super.httpClientAdapter,
  }) : super(
          BaseOptions(
            baseUrl: BaseStringHelper.get().baseUrl,
            sendTimeout: BaseStringHelper.get().timeout,
            connectTimeout: BaseStringHelper.get().timeout,
            receiveTimeout: BaseStringHelper.get().timeout,
          ),
        );
}
