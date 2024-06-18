class UserInfoModel {
  final int id;
  final String name;
  final String profileImageUrl;
  final bool authentication;
  final int followerCount;

  UserInfoModel({
    required this.id,
    required this.name,
    required this.profileImageUrl,
    required this.authentication,
    required this.followerCount,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      id: json['id'],
      name: json['name'],
      profileImageUrl: json['profileImageUrl'],
      authentication: json['authentication'],
      followerCount: json['followerCount'],
    );
  }
}
