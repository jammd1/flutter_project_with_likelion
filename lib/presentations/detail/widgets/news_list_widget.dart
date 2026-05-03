import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/presentations/detail/widgets/news_item_widget.dart';
import 'package:my_flutter_mini_project/providers/news_provider.dart';
import 'package:provider/provider.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        if (newsProvider.isLoading) {
          return Center(child: CircularProgressIndicator(color: Colors.lightBlueAccent,));
        }
        if (newsProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error, size: 64, color: Colors.red),
                SizedBox(height: 16),
                Text(
                  '뉴스를 불러올 수 없습니다. \n ${newsProvider.error}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    newsProvider.refreshNews();
                  },
                  child: Text('다시 시도'),
                ),
              ],
            ),
          );
        }
        if (newsProvider.articles.isEmpty) {
          return Center(
            child: Text(
              '뉴스가 없습니다.',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsetsGeometry.all(16),
            itemCount: newsProvider.articles.length,
            itemBuilder: (context, idx) {
            final article = newsProvider.articles[idx];
            return Card(
              margin: EdgeInsetsGeometry.only(bottom: 12),
              child: NewsItemWidget(article),
            );
            }
        );
      },
    );
  }
}
