import 'package:flutter/material.dart';
import 'feature_card_widget.dart';

class AboutPortraitWidget extends StatelessWidget{
  const AboutPortraitWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.lightBlueAccent
            ),
            child: Icon(
              Icons.travel_explore,
              size: 100,
              color: Colors.white
            ),
          ),
          SizedBox(height: 24,),
          Text(
            'Tripy',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Colors.lightBlueAccent
            ),
          ),
          SizedBox(height: 16,),
          Text(
            '와 함께 세계 여행을 계획하고 관리하세요.',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),
          ),
          SizedBox(height: 20,),
          FeatureCardWidget(
              icon: Icons.flight_takeoff,
              title: '항공편 예약',
              description: '전세계 항공편을 쉽게 검색하고 예약하세요.'
          ),
          SizedBox(height: 20,),
          FeatureCardWidget(
              icon: Icons.hotel,
              title: '호텔 예약',
              description: '최고의 호텔을 찾아 편안한 여행을 즐기세요.'
          ),
          SizedBox(height: 20,),
          FeatureCardWidget(
              icon: Icons.map,
              title: '여행 가이드',
              description: '현지 정보와 추천 명소를 확인하세요.'
          ),
          SizedBox(height: 32,),
          Text(
              'Version 1.0.0',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}