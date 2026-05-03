import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/presentations/my_info/widgets/my_info_empty_state_widget.dart';
import 'package:my_flutter_mini_project/presentations/my_info/widgets/my_info_form_widget.dart';
import 'package:my_flutter_mini_project/providers/user_info_provider.dart';
import 'package:provider/provider.dart';

import '../../core/routes/app_routes.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  bool showForm = false;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserInfoProvider>(context, listen: false);
    if (userProvider.userInfo != null) {
      showForm = true;
    }
  }
  void handleShowForm(bool shouldShow) {
    setState(() {
      showForm = shouldShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('My Info'),
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (r) => false,
              );
            },
            icon: Icon(Icons.home),
          ),
        ],
      ),
      body:  Consumer<UserInfoProvider>(
        builder: (context, userInfoProvider, child) {
          if (!userInfoProvider.hasUserInfo && !showForm) {
            return MyInfoEmptyStateWidget(showForm: handleShowForm);
          } else {
            return MyInfoFormWidget();
          }
        },
      )
    );
  }
}
