import 'package:coflow_login_practice/util/cookie_jar.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../viewmodel/member_view_model.dart';

class DioApi {
  late Dio dio;
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final String server = dotenv.get("SERVER");

  DioApi() {
    dio = Dio();

    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      String? accessToken = await storage.read(key: "accessToken");

      options.headers["Authorization"] = accessToken;

      return handler.next(options);
    }, onError: (e, handler) async {
      debugPrint("error response: ${e.response}");
      if ((e.response?.statusCode == 401 || e.response?.statusCode == 403) &&
          !e.requestOptions.extra.containsKey("retry")) {
        e.requestOptions.extra["retry"] = true;

        try {
          // 앱 내부 저장소 쿠키 포함 전송
          final CookieJar cookieJar = await customCookieJar();
          dio.interceptors.add(CookieManager(cookieJar));
          final refreshResponse = await dio.get("$server/member/refresh");
          dio.interceptors.remove(CookieManager(cookieJar));

          // todo: member 상태 업데이트
          final memberProvider = ProviderContainer().read(memberViewModelProvider);
          memberProvider.setMember(refreshResponse);

          final accessToken = refreshResponse.headers["Authorization"]?.first;
          e.response?.requestOptions.headers["Authorization"] = accessToken;
          final retryResponse = await dio.fetch(e.requestOptions);
          return handler.resolve(retryResponse);
        } catch (error) {
          debugPrint("error: $error");
          return handler.reject(DioException(requestOptions: e.requestOptions));
        }
      }

      return handler.next(e);
    }));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) {
    return dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) {
    return dio.post(path, data: data);
  }
}
