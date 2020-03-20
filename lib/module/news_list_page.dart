///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdailyzhihuapp/base/page/base_page.dart';
import 'package:flutterdailyzhihuapp/base/router.dart';
import 'package:flutterdailyzhihuapp/module/news_list_widget.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_bloc.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_event.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_state.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class NewsListPage extends BasePage<NewsListPage, NewsBloc> {
  static const String router = Router.baseRoute + 'news';

  NewsListPage({Key key}) : super(key: key, routerName: router);

  @override
  String get barTile => 'NewsList';

  @override
  NewsBloc getBLoc({BuildContext context}) =>
      BlocProvider.of<NewsBloc>(context);

  //加载失败界面
  Widget _getErrorWidget(String error) {
    return Container(
//      color: Colors.deepOrange,
      child: InkWell(
        onTap: () {
          bloc.add(NewsInitEvent());
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('出现了一些错误，点击重试，错误如下：'),
              Text('Error occured: $error'),
            ],
          ),
        ),
      ),
    );
  }

  //加载空界面
  Widget _getLoadingWidget() {
    return Container(
//      color: Colors.deepOrange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text('载入中...'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget getBody(BuildContext context) {
    return BlocBuilder<NewsBloc,NewsState>(
      bloc: bloc,
      builder: (context,NewsState state){
        if(state is NewsInitialState){
          return _getLoadingWidget();
        }else if(state is NewsErrorState){
          return _getErrorWidget('出错了,点击重试');
        }else if(state is NewsSuccessState){
          return NewsListWidget(
            stories: state.datas,
            topStories: state.topStories,
          );
        }
        return _getErrorWidget('出错了,点击重试');
      },
    );
  }
}
