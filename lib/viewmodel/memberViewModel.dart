import 'package:coflow_login_practice/repository/memberRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final memberViewModelProvider =
    ChangeNotifierProvider((ref) => MemberViewModel());

class MemberViewModel with ChangeNotifier {
  var memberRepository = MemberRepository();

  String getEmail() => memberRepository.member.email;

  String getUsername() => memberRepository.member.username;

  void login(String email, String password) async {
    await memberRepository.login(email, password);
    notifyListeners();
  }

  void fetchMemberInfo() async {
    await memberRepository.getMemberInfo();
    notifyListeners();
  }
}
