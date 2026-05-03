import 'package:flutter/material.dart';


/// 홈 상단 위젯 - 구성요소: 여행 광고
class HomeTopWidget3 extends StatelessWidget{
  const HomeTopWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('lib/core/assets/images/main_japan.jpg', fit: BoxFit.cover,),
        Container(
          padding: EdgeInsetsGeometry.only(top: 70, left: 50),
          child: Column(
            children: [
              Text(
                '\u{1F1EF}\u{1F1F5}아시아 특별 할인 일본편\u{1F1EF}\u{1F1F5}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900
                ),

              ),
              SizedBox(height: 5,),
              Text(
                '최대 30% 할인',
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