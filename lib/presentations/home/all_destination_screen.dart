

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/trip_provider.dart';
import 'widgets/home_grid_widget.dart';


class AllDestinationScreen extends StatefulWidget{
  const AllDestinationScreen({super.key});


  @override
  State<AllDestinationScreen> createState() => _AllDestinationState();
}

class _AllDestinationState extends State<AllDestinationScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('여행지 전체 (${Provider.of<TripProvider>(context, listen: false).destinations.length})'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                children: [
                  Expanded(
                    child: Consumer<TripProvider>(
                      builder: (ctx, provider, child) {
                        if (provider.isLoading) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (provider.error != null) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.wifi_off, size: 48, color: Colors.grey),
                                SizedBox(height: 8),
                                Text('서버에 연결할 수 없습니다.', style: TextStyle(color: Colors.grey)),
                                SizedBox(height: 8),
                                TextButton(
                                  onPressed: () => provider.getDestinations(),
                                  child: Text('다시 시도'),
                                ),
                              ],
                            ),
                          );
                        }
                        if (provider.destinations.isEmpty) {
                          return Center(child: Text('여행지 정보가 없습니다.'));
                        }
                        return HomeGridWidget(destinations: provider.destinations,);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}