import 'package:flutter/material.dart';
import 'package:flutter_netflix_responsive_ui/data/data.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffeset = 0.0;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _scrollOffeset = _scrollController.offset;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[850],
          child: const Icon(Icons.cast),
          onPressed: () {},
        ),
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 50),
          child: CustomAppBar(scrollOffeset: _scrollOffeset),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: const [
            SliverToBoxAdapter(
                child: ContentHeader(
              featuredContent: sintelContent,
            )),
            SliverPadding(
              padding: EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                child: Previews(
                  key: PageStorageKey("previews"),
                  title: 'Previews',
                  contentList: previews,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey('myList'),
                title: 'My List',
                contentList: myList,
              ),
            ),
            SliverToBoxAdapter(
              child: ContentList(
                key: PageStorageKey('originals'),
                title: 'Netflix Originals',
                contentList: originals,
                isOriginals: true,
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 20.0),
              sliver: SliverToBoxAdapter(
                child: ContentList(
                  key: PageStorageKey('trending'),
                  title: 'Trending',
                  contentList: trending,
                ),
              ),
            )
          ],
        ));
  }
}
