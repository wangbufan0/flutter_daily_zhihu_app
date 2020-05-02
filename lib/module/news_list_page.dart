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
import 'package:flutterdailyzhihuapp/theme/theme_page.dart';

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
  Widget getBar(BuildContext context) {
    DateTime date = DateTime.now();
    return PreferredSize(
      preferredSize: Size.fromHeight(54),
      child: Container(
        color: Theme.of(context).primaryColor,
        child: DefaultTextStyle(
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          child: Padding(
            padding: const EdgeInsets.only(top:30.0,left: 10,right: 10,bottom: 5),
            child: Row(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text('${date.day}'),
                        Text('${date.month}月',style: TextStyle(
                          inherit: false,
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
//                      height: 20,
                      width: 1,
                      color: Colors.grey[100],
                    ),
                    Text('Demo-知乎日报'),
                  ],
                ),

                Expanded(child: Container(),),
                IconButton(
                  icon: Icon(Icons.color_lens,color: Colors.white,),
                  onPressed: () => Navigator.pushNamed(context, ThemePage.router),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
    return BlocBuilder<NewsBloc, NewsState>(
      bloc: bloc,
      builder: (context, NewsState state) {
        if (state is NewsInitialState) {
          return _getLoadingWidget();
        } else if (state is NewsErrorState) {
          return _getErrorWidget('出错了,点击重试');
        } else if (state is NewsSuccessState) {
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
