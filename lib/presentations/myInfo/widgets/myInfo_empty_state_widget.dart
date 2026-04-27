import 'package:flutter/material.dart';

class MyInfoEmptyStateWidget extends StatelessWidget {
  final Function(bool) showForm;
  const MyInfoEmptyStateWidget({super.key, required this.showForm});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.person_off_outlined, size: 100, color: Colors.grey),
          SizedBox(height: 24),
          Text(
            '사용자 정보가 없습니다.',
            style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showForm(true);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent),
            ),
            child: Text('사용자 정보 만들기', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
