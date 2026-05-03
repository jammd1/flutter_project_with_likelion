import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/models/trip_destination.dart';
import '../../../models/schedule.dart';

class ProductDetailDialogWidget extends StatelessWidget {
  final TripDestination destination;
  final int idx;
  const ProductDetailDialogWidget(this.destination, this.idx, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${destination.name} 여행 상품 ${idx + 1}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              '닫기',
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(12),
              child: Image.network(
                destination.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          SummaryCard(),
          SizedBox(height: 20),
          Text(
            '상세 일정',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: Row(
              children: [
                Icon(Icons.date_range, color: Colors.lightBlueAccent, size: 30,),
                SizedBox(width: 8,),
                Text('1일차', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)
              ],
            ),
          ),
          SizedBox(height: 10,),
          ScheduleCard(schedules: [
            Schedule('인천 공항 출발 (대한항공 KE093, 13:20'),
            Schedule('취리히 공항 도착 후 호텔 체크인'),
            Schedule('취리히 구시가지 자유 관광'),
          ], day: 1,),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: Row(
              children: [
                Icon(Icons.date_range, color: Colors.lightBlueAccent, size: 30,),
                SizedBox(width: 8,),
                Text('2일차', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)
              ],
            ),
          ),
          SizedBox(height: 10,),
          ScheduleCard(schedules: [
            Schedule('루체른 이동 (약 1시간)'),
            Schedule('카펠교 및 빈사의 사자상 관람'),
            Schedule('리기산 등반 및 파노라마 전망 감상'),
          ], day: 2,),
          SizedBox(height: 20,),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: Row(
              children: [
                Icon(Icons.date_range, color: Colors.lightBlueAccent, size: 30,),
                SizedBox(width: 8,),
                Text('3일차', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)
              ],
            ),
          ),
          SizedBox(height: 10,),
          ScheduleCard(schedules: [
            Schedule('인터라켄 이동 (약 2시간)'),
            Schedule('융프라우요흐 등반 (유럽의 지붕, 3454m)'),
            Schedule('알프스 설원 자유 시간')
          ], day: 3,),
          SizedBox(height: 30)
        ],
      ),
    );
  }
}

class ScheduleCard extends StatelessWidget {
  final List<Schedule> schedules;
  final int day;
  const ScheduleCard({
    super.key,
    required this.schedules,
    required this.day
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: BoxBorder.all(color: Colors.lightBlueAccent, width: 3),
        borderRadius: BorderRadiusGeometry.circular(14),
      ),
      padding: EdgeInsetsGeometry.only(bottom: 10),
      child: ListView.separated(
        shrinkWrap: true,
          itemBuilder: (context, idx) => Row(
            children: [
              Icon(
                Icons.push_pin_outlined,
                size: 20,
                color: Colors.lightBlueAccent,
              ),
              Text(
                schedules[idx].schedule,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          separatorBuilder: (_,idx) => SizedBox(height: 8,),
          itemCount: schedules.length
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.date_range, size: 30, color: Colors.lightBlueAccent),
                SizedBox(width: 4),
                Text(
                  '일정',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  ': 1월 1일 ~ 1월 15일 (14박 15일)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 30,
                  color: Colors.lightBlueAccent,
                ),
                SizedBox(width: 4),
                Text(
                  '가격',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  ': 350만원',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.flight, size: 30, color: Colors.lightBlueAccent),
                SizedBox(width: 4),
                Text(
                  '항공',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  ': 대한항공',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.hotel, size: 30, color: Colors.lightBlueAccent),
                SizedBox(width: 4),
                Text(
                  '호텔',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  ': 전 일정 4성급 이상 호텔',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
