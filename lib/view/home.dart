import 'package:coflow_login_practice/viewmodel/memberViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var viewModel = ref.watch(memberViewModelProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FilledButton(
                onPressed: () =>
                    viewModel.login(dotenv.get("TEST_EMAIL"),dotenv.get("TEST_PASSWORD")),
                child: Text("login")),
            Text(viewModel.getEmail()),
            Text(viewModel.getUsername()),
          ],
        ),
      )),
    );
  }
}
