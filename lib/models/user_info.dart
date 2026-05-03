class UserInfo {
  String? name;
  String? email;
  String? profileImagePath;

  UserInfo({
    this.name,
    this.email,
    this.profileImagePath
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profileImagePath': profileImagePath
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> userInfoMap) {
    return UserInfo(
      name: userInfoMap['name'],
      email: userInfoMap['email'],
      profileImagePath: userInfoMap['profileImagePath'],
    );
  }


}