import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/core/routes/app_routes.dart';
import 'package:my_flutter_mini_project/presentations/about/widgets/about_landscape_widget.dart';
import 'package:my_flutter_mini_project/presentations/about/widgets/about_portrait_widget.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
      backgroundColor: Colors.white,
      body: OrientationBuilder(
        builder: (ctx, ortn) {
          if (ortn == Orientation.portrait) {
            return AboutPortraitWidget();
          } else {
            return AboutLandscapeWidget();
          }
        },
      ),
    );
  }
}
