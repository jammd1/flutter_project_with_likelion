
import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/models/trip_destination.dart';
import 'package:my_flutter_mini_project/presentations/detail/widgets/news_list_widget.dart';
import 'package:my_flutter_mini_project/presentations/detail/widgets/product_list_widget.dart';
import 'package:my_flutter_mini_project/providers/news_provider.dart';
import 'package:provider/provider.dart';


class DetailScreen extends StatefulWidget{
  final TripDestination destination;
  const DetailScreen(this.destination, {super.key});

  @override
  State<StatefulWidget> createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final newsProvider = Provider.of<NewsProvider>(context, listen: false);
        if (newsProvider.articles.isEmpty || newsProvider.query != widget.destination.country) {
          newsProvider.fetchNewsArticles(widget.destination.country);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.destination.name),
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.lightBlueAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.lightBlueAccent,
          tabs: [
            Tab(text: '상품'),
            Tab(text: '여행지 뉴스'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ProductListWidget(widget.destination),
          NewsListWidget()
        ],
      ),
    );
  }
}