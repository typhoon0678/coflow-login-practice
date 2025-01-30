class Member {
  int? status;
  String? email;
  String? username;
  List<String>? roles;

  Member({this.status, this.email, this.username, this.roles});

  Member.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    email = json['email'];
    username = json['username'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['email'] = email;
    data['username'] = username;
    data['roles'] = roles;
    return data;
  }
}
