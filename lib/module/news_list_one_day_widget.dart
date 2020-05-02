import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdailyzhihuapp/base/page/base_page.dart';
import 'package:flutterdailyzhihuapp/module/news_detail_list_page.dart';
import 'package:flutterdailyzhihuapp/module/news_detail_page.dart';
import 'package:flutterdailyzhihuapp/news_data_entity.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class NewsListOneDayWidget extends StatelessWidget {
  final NewsDataEntity data;

  const NewsListOneDayWidget({Key key, this.data}) : super(key: key);

  int _getIndex(NewsDataStory data) {
    int index = 0;
    for (NewsDataStory data1 in this.data.stories) {
      if (data1.id == data.id) {
        return index;
      }
      index++;
    }
  }

  Widget _getListTile2(BuildContext context, NewsDataStory data) {
    return FlatButton(
      onPressed: () {
//        NewsDetailPage.launch(context, url: data.url);
        NewsDetailListPage.launch(
          context,
          isTop: false,
          initIndex: _getIndex(data),
          date: this.data.date,
        );
      },
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      highlightColor: Colors.grey,
      splashColor: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.title,
                    maxLines: 2,
                    textScaleFactor: 1.3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      data.hint,
                      maxLines: 1,
                      textScaleFactor: 0.9,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              data.images.first,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: data.stories.map((NewsDataStory data) {
          return SizedBox(
            height: 110,
            child: _getListTile2(context, data),
          );
        }).toList(),
      ),
    );
  }
}
