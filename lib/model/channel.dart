class Channel {
  String? id;
  String? channelName;

  Channel({this.id, this.channelName});

  Channel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    channelName = json['channelName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['channelName'] = channelName;
    return data;
  }
}
