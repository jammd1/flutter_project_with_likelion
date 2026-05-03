import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_mini_project/providers/user_info_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/user_info.dart';

class MyInfoFormWidget extends StatefulWidget {
  const MyInfoFormWidget({super.key});

  @override
  State<StatefulWidget> createState() => _MyInfoFormWidgetState();
}

class _MyInfoFormWidgetState extends State<MyInfoFormWidget> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _imagePicker = ImagePicker();
  String? profileImagePath;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserInfoProvider>(context, listen: false);
    if (userProvider.userInfo != null) {
      _nameController.text = userProvider.userInfo!.name ?? '';
      _emailController.text = userProvider.userInfo!.email ?? '';
      profileImagePath = userProvider.userInfo!.profileImagePath ?? '';
    }
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('프로필 사진 선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('카메라로 촬영'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFrom(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.image_search),
                title: Text('갤러리에서 선택'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFrom(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFrom(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        setState(() {
          profileImagePath = image.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('이미지 선택 중 오류가 발생했습니다.')));
      }
      debugPrint(e.toString());
    }
  }

  void _saveUserInfo() async {
    if (_nameController.text.trim().isEmpty ||
        _emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('이름 또는 이메일을 입력해주세요.')));
      return;
    }
    // 저장할 객체 조립
    final userInfo = UserInfo(
      name: _nameController.text.trim().isEmpty
          ? null
          : _nameController.text.trim(),
      email: _emailController.text.trim().isEmpty
          ? null
          : _emailController.text.trim(),
      profileImagePath: profileImagePath,
    );

    try {
      await Provider.of<UserInfoProvider>(
        context,
        listen: false,
      ).updateUserInfo(userInfo);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('사용자 정보가 저장되었습니다.')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('저장 중 오류가 발생했습니다.')));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        children: [
          Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: (profileImagePath?.isNotEmpty ?? false)
                      ? FileImage(File(profileImagePath!))
                      : AssetImage('lib/core/assets/images/user_basic.jpg'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: FloatingActionButton(
                    onPressed: _showImagePickerDialog,
                    mini: true,
                    child: Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          TextField(
            cursorColor: Colors.lightBlueAccent,
            controller: _nameController,
            decoration: InputDecoration(
              labelText: '이름',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
              prefixIconColor: WidgetStateColor.resolveWith((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.focused)) {
                  return Colors.lightBlueAccent;
                }
                return Colors.black;
              }),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
              ),
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          SizedBox(height: 16),
          TextField(
            cursorColor: Colors.lightBlueAccent,
            controller: _emailController,
            decoration: InputDecoration(
              labelText: '이메일',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
              prefixIconColor: WidgetStateColor.resolveWith((
                Set<WidgetState> states,
              ) {
                if (states.contains(WidgetState.focused)) {
                  return Colors.lightBlueAccent;
                }
                return Colors.black;
              }),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2),
              ),
            ),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _saveUserInfo,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                '저장',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
