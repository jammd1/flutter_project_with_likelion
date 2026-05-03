import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/models/news_article.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItemWidget extends StatelessWidget {
  final NewsArticle article;
  const NewsItemWidget(this.article, {super.key});

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
    return ListTile(
      leading: article.imageUrl != null
          ? Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(article.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey,
              ),
            ),
      title: Text(
        article.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 4,),
          Text(
            article.source ?? '',
            style: TextStyle(
              fontSize: 12,
              color: Colors.lightBlueAccent
            ),
          )
        ],
      ),
      onTap: () {
        final Uri url = Uri.parse(article.url);
        _launchUrl(url, context);
      },
    );
  }
}
