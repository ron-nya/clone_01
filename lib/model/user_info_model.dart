class UserInfoModel {
  final String id;
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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "profileImageUrl": profileImageUrl,
      "authentication": authentication,
      "followerCount": followerCount,
    };
  }

  UserInfoModel.empty()
      : id = '',
        name = '',
        profileImageUrl = '',
        authentication = false,
        followerCount = 0;
}
