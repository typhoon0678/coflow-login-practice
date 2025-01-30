import 'package:coflow_login_practice/model/member.dart';
import 'package:coflow_login_practice/util/dio_api.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../util/cookie_jar.dart';

class MemberRepository {

  Member member = Member();

  final DioApi dio = DioApi();
  final Dio dioLogin = Dio();
  final storage = FlutterSecureStorage();
  final String server = dotenv.get("SERVER");

  Future<void> login(String email, String password) async {
    try {
      final CookieJar cookieJar = await customCookieJar();
      dioLogin.interceptors.add(CookieManager(cookieJar));
      var response = await dioLogin.post("$server/member/login", data: {
        "email": email,
        "password": password,
      });
      dioLogin.interceptors.remove(CookieManager(cookieJar));

      setMember(response);
    } catch (err, stackTrace) {
      debugPrint("$err, $stackTrace");
    }
  }

  Future<void> getMemberInfo() async {
    try {
      var response = await dio.get("$server/member/info");
      member = Member.fromJson(response.data);
    } catch (err, stackTrace) {
      debugPrint("$err, $stackTrace");
    }
  }

  Future<void> setMember(var response) async {
    final accessToken = response.headers["Authorization"]?.first;
    await storage.write(key: "accessToken", value: accessToken);

    member = Member.fromJson(response.data);
  }
}
