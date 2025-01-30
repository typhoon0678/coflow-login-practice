import 'package:coflow_login_practice/model/channel.dart';
import 'package:coflow_login_practice/repository/chat_channel_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatChannelViewModelProvider =
    ChangeNotifierProvider((ref) => ChatChannelViewModel());

class ChatChannelViewModel with ChangeNotifier {
  var chatChannelRepository = ChatChannelRepository();

  List<Channel> getChannelList() => chatChannelRepository.channelList;

  void fetchChannelList() async {
    await chatChannelRepository.getChannelList();
    notifyListeners();
  }
}
