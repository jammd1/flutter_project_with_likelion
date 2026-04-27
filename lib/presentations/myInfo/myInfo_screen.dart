import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/presentations/myInfo/widgets/myInfo_empty_state_widget.dart';
import 'package:my_flutter_mini_project/presentations/myInfo/widgets/myInfo_form_widget.dart';

import '../../core/routes/app_routes.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  bool showForm = false;


  void handleShowForm(bool shouldShow) {
    setState(() {
      showForm = shouldShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('My Info'),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
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
      body: showForm ? MyInfoFormWidget() : MyInfoEmptyStateWidget(showForm: handleShowForm),
    );
  }
}
