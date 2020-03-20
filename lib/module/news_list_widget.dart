import 'package:bloc/bloc.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterdailyzhihuapp/base/page/base_page.dart';
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


  Widget getSwiper() {
    return Swiper(
      itemBuilder: (context, index) {
        return Image.network(
          topStories[index].image,
          fit: BoxFit.fill,
        );
      },
      itemCount: 5,
      pagination: SwiperPagination(),
      autoplay: true,
    );
  }

  Widget getBody() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: SizedBox(
            height: 250,
            child: getSwiper(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              NewsDataEntity data=stories[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: index==0?null:Text(data.date),
                  )
                  ,
                  NewsListOneDayWidget(data: data,),
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
      child: getBody(),
    );
    ;
  }
}
