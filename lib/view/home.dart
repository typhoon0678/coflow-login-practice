import 'package:coflow_login_practice/util/cookie_jar.dart';
import 'package:coflow_login_practice/viewmodel/chat_channel_view_model.dart';
import 'package:coflow_login_practice/viewmodel/member_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var memberProvider = ref.watch(memberViewModelProvider);
    var chatChannelProvider = ref.watch(chatChannelViewModelProvider);
    final storage = FlutterSecureStorage();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (memberProvider.isLogin())
                ? FilledButton(onPressed: () => {}, child: Text("logout"))
                : FilledButton(
                    onPressed: () => memberProvider.login(
                        dotenv.get("TEST_EMAIL"), dotenv.get("TEST_PASSWORD")),
                    child: Text("login")),
            Text(memberProvider.getEmail() ?? ""),
            Text(memberProvider.getUsername() ?? ""),
            FilledButton(
                onPressed: () async =>
                    print(await storage.read(key: "accessToken")),
                child: Text("AccessToken")),
            FilledButton(
                onPressed: () async => await storage.delete(key: "accessToken"),
                child: Text("Remove AccessToken")),
            FilledButton(
                onPressed: () async => await listCookies(),
                child: Text("쿠키 확인")),
            FilledButton(
                onPressed: () => chatChannelProvider.fetchChannelList(),
                child: Text("채널 목록")),
            Column(
              children: chatChannelProvider.getChannelList().map((channel) {
                return Text(channel.channelName ?? "");
              }).toList(),
            ),
          ],
        ),
      )),
    );
  }
}
