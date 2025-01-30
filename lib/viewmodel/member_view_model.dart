import 'package:coflow_login_practice/model/member.dart';
import 'package:coflow_login_practice/repository/member_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberViewModelProvider =
    ChangeNotifierProvider((ref) => MemberViewModel());


class MemberViewModel with ChangeNotifier {

  var memberRepository = MemberRepository();

  bool isLogin() => memberRepository.member.email != null;

  String? getEmail() => memberRepository.member.email;

  String? getUsername() => memberRepository.member.username;

  void login(String email, String password) async {
    await memberRepository.login(email, password);
    notifyListeners();
  }

  void fetchMemberInfo() async {
    await memberRepository.getMemberInfo();
    notifyListeners();
  }

  void setMember(var responseData) {
    memberRepository.setMember(responseData);
    notifyListeners();
  }
}
