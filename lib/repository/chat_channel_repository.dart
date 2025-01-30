import 'package:coflow_login_practice/model/channel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../util/dio_api.dart';

class ChatChannelRepository {
  List<Channel> channelList = [];

  final DioApi dio = DioApi();
  final storage = FlutterSecureStorage();
  final String server = dotenv.get("SERVER");

  Future<void> getChannelList() async {
    try {
      var response = await dio.get("$server/chat/channel");

      channelList =
          response.data.map<Channel>((json) => Channel.fromJson(json)).toList();
    } catch (err, stackTrace) {
      debugPrint("$err, $stackTrace");
    }
  }
}
