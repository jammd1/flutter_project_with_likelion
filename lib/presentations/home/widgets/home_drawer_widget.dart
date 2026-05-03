import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/providers/user_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/routes/app_routes.dart';

class HomeDrawerWidget extends StatelessWidget {
  const HomeDrawerWidget({super.key});
  
  
  Future<void> _launchUrl(Uri url, BuildContext context) async {
    try {
      await launchUrl(url);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('해당 url을 열 수 없습니다. $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsetsGeometry.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Consumer<UserInfoProvider>(
              builder: (context, userInfoProvider, child) {
                final name = userInfoProvider.userInfo?.name ?? '게스트';
                return Text(name);
              },
            ),
            accountEmail: Consumer<UserInfoProvider>(
              builder: (context, userInfoProvider, child) {
                final email = userInfoProvider.userInfo?.email ?? '-';
                return Text(email);
              },
            ),
            currentAccountPicture: Consumer<UserInfoProvider>(
              builder: (context, userInfoProvider, child) {
                final profileImagePath = userInfoProvider.userInfo?.profileImagePath ?? '';
                return CircleAvatar(
                  backgroundImage: profileImagePath.isNotEmpty
                      ? FileImage(File(profileImagePath))
                      : AssetImage('lib/core/assets/images/user_basic.jpg'),
                );
              },
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
          ListTile(
            leading: Icon(Icons.event_note_outlined),
            title: Text('AI Trip Planning'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.plan);
            }
          ),
          ExpansionTile(
              leading: Icon(Icons.flight_takeoff),
              title: Text('Get Flights'),
            children: [
              ListTile(
                onTap: () {
                  final url = Uri.parse('https://kr.trip.com/flights/?locale=ko-KR&curr=KRW');
                  Navigator.pop(context);
                  _launchUrl(url, context);
                  
                },
                leading: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.asset(
                    'lib/core/assets/images/trip_com.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Trip.com'),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  final url = Uri.parse('https://www.google.com/travel/flights?hl=ko');
                  Navigator.pop(context);
                  _launchUrl(url, context);
                },
                leading: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.asset(
                    'lib/core/assets/images/google_travel.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Google Travel'),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  final url = Uri.parse('https://flight.naver.com/');
                  Navigator.pop(context);
                  _launchUrl(url, context);
                },
                leading: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.asset(
                    'lib/core/assets/images/naver.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Naver Flight'),
              ),
              SizedBox(height: 10,)
            ],
          ),
          ExpansionTile(
            leading: Icon(Icons.hotel),
            title: Text('Get Hotels'),
            children: [
              ListTile(
                onTap: () {
                  final url = Uri.parse('https://kr.hotels.com/?locale=ko_KR&siteid=300000041&semcid=HCOM-KR.UB.GOOGLE.GT-c-KO.HOTEL&semdtl=a121749369188.b1166664879743.g1kwd-327674006524.e1c.m1Cj0KCQjw2MbPBhCSARIsAP3jP9xNrAWq3AVCDXNQd_wjcBgLpjAk3qeuaQPfPmxLeQWZh3eN2_H2rQMaApBpEALw_wcB.r1.c1.j11030780.k1.d1716263657908.h1e.i1.l1.n1.o1.p1.q1.s1%ED%98%B8%ED%85%94%20%EC%98%88%EC%95%BD.t1.x1.f1.u1.v1.w1&gad_source=1&gad_campaignid=21749369188&gbraid=0AAAAACTxZ9ZpUFDeJ7zClKeLo4Pk67BN7&gclid=Cj0KCQjw2MbPBhCSARIsAP3jP9xNrAWq3AVCDXNQd_wjcBgLpjAk3qeuaQPfPmxLeQWZh3eN2_H2rQMaApBpEALw_wcB');
                  Navigator.pop(context);
                  _launchUrl(url, context);

                },
                leading: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.asset(
                    'lib/core/assets/images/hotels_com.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Hotels.com'),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  final url = Uri.parse('https://www.agoda.com/ko-kr/?cid=1922868&tag=4453e370-eb1e-4ba3-932a-dc1ec1088ad1&gclid=Cj0KCQjw2MbPBhCSARIsAP3jP9zVEA4y8sWE40SJ_bpgO80r2dh1JFz5qyC3Ue1OVJZot3Mc6AnCTzMaAn2iEALw_wcB&ds=KWpGKQMB6MMyw52h');
                  Navigator.pop(context);
                  _launchUrl(url, context);
                },
                leading: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.asset(
                    'lib/core/assets/images/agoda.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Agoda'),
              ),
              Divider(),
              ListTile(
                onTap: () {
                  final url = Uri.parse('https://www.airbnb.co.kr/');
                  Navigator.pop(context);
                  _launchUrl(url, context);
                },
                leading: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10),
                  child: Image.asset(
                    'lib/core/assets/images/airbnb.png',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text('Airbnb'),
              ),
              SizedBox(height: 10,)
            ],
          )
        ],
      ),
    );
  }
}
