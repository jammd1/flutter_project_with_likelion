import 'package:flutter/material.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_drawer_widget.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_grid_widget.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_middle_widget.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_to_widget_2.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_top_widget_1.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_top_widget_3.dart';
import 'package:my_flutter_mini_project/presentations/home/widgets/home_top_widget_4.dart';
import 'package:my_flutter_mini_project/providers/search_history_provider.dart';
import 'package:my_flutter_mini_project/providers/theme_provider.dart';
import 'package:my_flutter_mini_project/providers/trip_provider.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearching = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: _isSearching
              ? Consumer<SearchHistoryProvider>(
                  builder: (context, historyProvider, _) {
                    return Autocomplete(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        return textEditingValue.text.isEmpty
                            ? historyProvider.history
                            : <String>[];
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        return Material(
                          color: Theme.of(context).colorScheme.surface,
                          child: ListView.builder(
                            itemCount: historyProvider.history.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, idx) {
                              return ListTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    historyProvider.removeHistory(
                                      historyProvider.history[idx],
                                    );
                                  },
                                  icon: Icon(Icons.close),
                                ),
                                leading: Icon(Icons.history),

                                title: Text(
                                  historyProvider.history[idx],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                          ),
                        );
                      },
                      fieldViewBuilder:
                          (context, controller, focusNode, onFieldSubmitted) {
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: '여행지를 검색해보세요',
                                border: InputBorder.none,
                              ),
                              onTapOutside: (pointer) {
                                setState((){
                                  _isSearching = false;
                                });
                              },
                              textInputAction: TextInputAction.search,
                              onSubmitted: (_) {
                                historyProvider.addHistory(controller.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('검색어: ${controller.text}'),
                                  ),
                                );
                                controller.clear();
                                setState(() {
                                  _isSearching = false;
                                });
                              },
                            );
                          },
                    );
                  },
                )
              : Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Tripy', style: TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.w900)),
                ),
        ),
        actions: [
          if (!_isSearching) ...[
            IconButton(
              key: UniqueKey(),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
                debugPrint(_isSearching.toString());
              },
              icon: Icon(Icons.search),
            ),
            Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) {
                return PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () => themeProvider.toggle(),
                      child: Row(
                        children: [
                          Icon(themeProvider.isDark ? Icons.light_mode : Icons.dark_mode),
                          SizedBox(width: 12),
                          Text(themeProvider.isDark ? '라이트 모드' : '다크 모드'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ] else
            IconButton(
              key: UniqueKey(),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                });
                debugPrint(_isSearching.toString());
              },
              icon: Icon(Icons.close),
            ),
        ],
      ),
      drawer: HomeDrawerWidget(),
      body: Column(
        children: [
          // 홈 상단 위젯 - 구성 요소: 여행 광고
          CarouselSlider(
              items: [
                HomeTopWidget1(),
                HomeTopWidget2(),
                HomeTopWidget3(),
                HomeTopWidget4()
              ],
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                initialPage: 0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),

              )
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsGeometry.all(16),
              child: Column(
                children: [
                  // 홈 중단 위젯 - 구성 요소: 버튼
                  HomeMiddleWidget(),
                  SizedBox(height: 16),
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
                        return HomeGridWidget(destinations: provider.destinations.take(10).toList(),);
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
