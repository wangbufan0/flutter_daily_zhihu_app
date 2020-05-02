import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterdailyzhihuapp/base/utils/string_util.dart';
import 'package:flutterdailyzhihuapp/module/home_swiper_widget.dart';
import 'package:flutterdailyzhihuapp/module/news_list_one_day_widget.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_bloc.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_event.dart';

import '../news_data_entity.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email:wangbufan00@gmail.com
///

class NewsListWidget extends StatelessWidget {
  final List<NewsDataTopStory> topStories;
  final List<NewsDataEntity> stories;

  NewsListWidget({
    Key key,
    this.topStories,
    this.stories,
  }) : super(key: key);

  Widget _getDateLine(NewsDataEntity data) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(
            StringUtil.String2Date(data.date),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          padding: EdgeInsets.all(10),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
      ],
    );
  }

  Widget _getBody() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: HomeSwiperWidget(topStories: topStories),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              NewsDataEntity data = stories[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  index == 0
                      ? Container(
                          padding: EdgeInsets.only(top: 10),
                        )
                      : _getDateLine(data),
                  NewsListOneDayWidget(data: data),
                ],
              );
            },
            childCount: stories.length,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    onRefresh() async {
      BlocProvider.of<NewsBloc>(context).add(NewsRefreshEvent());
    }

    onLoading() async {
      BlocProvider.of<NewsBloc>(context).add(NewsLoadMoreEvent());
    }

    return EasyRefresh(
      header: MaterialHeader(),
      footer: MaterialFooter(),
      onRefresh: onRefresh,
      onLoad: onLoading,
      child: _getBody(),
      firstRefresh: true,
    );
  }
}
