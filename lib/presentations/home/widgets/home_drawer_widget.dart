import 'package:flutter/material.dart';

import '../../../core/routes/app_routes.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsetsGeometry.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('사용자'),
            accountEmail: Text('user1@naver.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                'lib/core/assets/images/user_basic.jpg',
              ),
            ),
            decoration: BoxDecoration(color: Colors.lightBlueAccent),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.about);
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('My Info'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.myInfo);
            },
          ),

        ],
      ),
    );
  }
}
