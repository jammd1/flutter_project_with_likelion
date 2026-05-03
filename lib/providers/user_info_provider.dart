
import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/models/user_info.dart';
import 'package:my_flutter_mini_project/services/storage_service.dart';

class UserInfoProvider with ChangeNotifier{
  UserInfo? _userInfo;

  UserInfo? get userInfo => _userInfo;

  bool get hasUserInfo => _userInfo != null && ((_userInfo!.name?.isNotEmpty ?? false) || (_userInfo!.email?.isNotEmpty ?? false));

  Future<void> loadUserInfo() async {
    _userInfo = await StorageService.instance.getUserInfo();
    notifyListeners();
  }

  Future<void> updateUserInfo(UserInfo userInfo) async {
    await StorageService.instance.insertOrUpdateUser(userInfo);
    _userInfo = userInfo;
    notifyListeners();
  }

  Future<void> clearUserInfo() async {
    _userInfo = null;
    notifyListeners();
  }
}