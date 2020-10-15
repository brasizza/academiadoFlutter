import 'package:dio/dio.dart';

class DioInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print('INICIANDO A REQUISICAO  ${options?.path}');
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print('RESPOSTA[${response?.statusCode}] => PATH: ${response?.request?.path}');
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print('ERRO [${err?.response?.statusCode}] => PATH: ${err?.request?.path}');
    return super.onError(err);
  }
}
