class Member {
  final String email;
  final String username;

  Member(this.email, this.username);

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(json['email'], json['username']);
  }
}
