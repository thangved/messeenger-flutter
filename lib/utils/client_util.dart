import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:messeenger_flutter/utils/token_util.dart';

class MyInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    final token = await TokenUtil.getToken();
    data.headers['authorization'] = 'Bearer $token';
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    return data;
  }
}

final client = InterceptedClient.build(interceptors: [MyInterceptor()]);
