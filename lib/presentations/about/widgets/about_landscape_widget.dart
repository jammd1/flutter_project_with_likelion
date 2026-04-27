import 'package:flutter/material.dart';

import 'feature_card_widget.dart';

class AboutLandscapeWidget extends StatelessWidget {
  const AboutLandscapeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsetsGeometry.all(16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.lightBlueAccent
                  ),
                  child: Icon(
                      Icons.travel_explore,
                      size: 80,
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
                  'Version 1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    '쉽게 세계 여행을 계획하고 관리하세요.',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
