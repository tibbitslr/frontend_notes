import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_api/news_api.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCard extends StatelessWidget {
  final Article data;

  const NewsCard(this.data, {Key key}) : super(key: key);

  Widget _getImage() {
    if (data.urlToImage == null) {
      return Container();
    }

    return AspectRatio(
      aspectRatio: 16.0 / 9.0,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(data.urlToImage),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          title: Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
              '${data.source.name}, published at ${DateFormat.yMMMMd().format(DateTime.parse(data.publishedAt))}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis),
          trailing: IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share('${data.title} ${data.url}');
            },
            color: Theme.of(context).buttonColor,
          ),
        ),
        _getImage(),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Text(
            data.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        ButtonTheme.bar(
          child: ButtonBar(
            alignment: MainAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'READ',
                  style: Theme.of(context).accentTextTheme.button,
                ),
                onPressed: () async {
                  if (await canLaunch(data.url)) {
                    await launch(data.url);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
