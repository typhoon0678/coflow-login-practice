import 'package:coflow_login_practice/model/member.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MemberRepository {
  Member member = Member("email", "username");

  final Dio dio = Dio();
  final String server = dotenv.get("SERVER");

  Future<void> login(String email, String password) async {
    try {
      var response = await dio.post("$server/member/login", data: {
        "email": email,
        "password": password,
      });
      member = Member.fromJson(response.data);
    } catch (err, stackTrace) {
      debugPrint("$err, $stackTrace");
    }
  }

  Future<void> getMemberInfo() async {
    try {
      var response = await dio.get("https://api.coflow.store/api/member/info");
      member = Member.fromJson(response.data);
    } catch (err, stackTrace) {
      debugPrint("$err, $stackTrace");
    }
  }
}
