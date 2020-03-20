import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterdailyzhihuapp/base/page/base_page.dart';
import 'package:flutterdailyzhihuapp/news_data_entity.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class NewsListOneDayWidget extends StatelessWidget {
  final NewsDataEntity data;

  const NewsListOneDayWidget({Key key, this.data}) : super(key: key);

  Widget _getListTile(NewsDataStory data) {
    return ListTile(
      title: Text(
        data.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        data.hint,
        maxLines: 1,
        textScaleFactor: 0.7,
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      trailing: Image.network(
        data.images.first,
        width: 80,
        height: 80,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemExtent: 100,
      children: data.stories.map((NewsDataStory data) {
        return _getListTile(data);
      }).toList(),
    );
  }
}
