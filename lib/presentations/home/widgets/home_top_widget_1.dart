import 'package:flutter/material.dart';


/// 홈 상단 위젯 - 구성요소: 여행 광고
class HomeTopWidget1 extends StatelessWidget{
  const HomeTopWidget1({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('lib/core/assets/images/main_bg_1.jpg', fit: BoxFit.cover,),
        Container(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            children: [
              Text(
                '연말 연시 특별 할인 이벤트',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900
                ),

              ),
              SizedBox(height: 5,),
              Text(
                  '최대 20% 할인',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}