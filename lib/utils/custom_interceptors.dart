import 'package:dio/dio.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print(
        "--> ${options.method.toUpperCase()} ${options.baseUrl} ${options.path}");
    print("Headers:");
    options.headers.forEach((k, v) => print('$k: $v'));
    print("queryParameters:");
    options.queryParameters.forEach((k, v) => print('$k: $v'));
    if (options.data != null) {
      print("Body: ${options.data}");
    }
    print("--> END ${options.method.toUpperCase()}");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        "<-- ${response.statusCode} ${response.requestOptions.baseUrl + response.requestOptions.path}");
    print("Headers:");
    response.headers.forEach((k, v) => print('$k: $v'));
    print("Response: ${response.data}");
    print("<-- END HTTP");
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError dioError, ErrorInterceptorHandler handler) {
    print(
        "<-- ${dioError.message} ${(dioError.response?.requestOptions != null ? ((dioError.response?.requestOptions.baseUrl ?? "") + (dioError.response?.requestOptions.path ?? "")) : 'URL')}");
    print(
        "${dioError.response != null ? dioError.response?.data : 'Unknown Error'}");
    print("<-- End error");
    return super.onError(dioError, handler);
  }
}
