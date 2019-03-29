import 'package:flutter/material.dart';
import 'package:frontend_notes/services/services.dart';
import 'package:frontend_notes/widgets/fn_card.dart';
import 'package:frontend_notes/widgets/news_card.dart';
import 'package:frontend_notes/widgets/widgets.dart';
import 'package:news_api/models/models.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  build(BuildContext context) {
    return Scaffold(
      drawer: FnDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              child: SliverToBoxAdapter(
                child: FnBar(actions: <Widget>[
                  GithubButton(),
                ]),
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: () => newsService.refresh(),
          child: SafeArea(
            top: false,
            bottom: false,
            child: StreamBuilder<List<Article>>(
              stream: newsService.articles,
              initialData: <Article>[],
              builder: (context, snapshot) {
                return CustomScrollView(
                  key: PageStorageKey<String>('name'),
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Filter(),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, int i) {
                          if (i == snapshot.data.length) {
                            newsService.nextPage();

                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            );
                          } else {
                            final article = snapshot.data[i];

                            return FnCard(
                              child: NewsCard(article),
                              isFirst: i == 0,
                              isLast: i == snapshot.data.length - 1,
                            );
                          }
                        },
                        childCount: snapshot.data.length + 1,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
