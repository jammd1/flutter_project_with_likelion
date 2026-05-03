import 'package:flutter/material.dart';


/// 홈 상단 위젯 - 구성요소: 여행 광고
class HomeTopWidget2 extends StatelessWidget{
  const HomeTopWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Image.asset('lib/core/assets/images/main_czech.jpg', fit: BoxFit.cover,),
        Container(
          padding: EdgeInsetsGeometry.symmetric(vertical: 40, horizontal: 40),
          child: Column(
            children: [
              Text(
                '\u{1F1E8}\u{1F1FF}체코 패키지 여행\u{1F1E8}\u{1F1FF}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900
                ),

              ),
              SizedBox(height: 5,),
              Text(
                '최대 15% 할인',
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