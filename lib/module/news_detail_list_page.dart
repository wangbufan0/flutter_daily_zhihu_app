import 'package:bot_toast/bot_toast.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterdailyzhihuapp/base/page/base_page.dart';
import 'package:flutterdailyzhihuapp/base/router.dart';
import 'package:flutterdailyzhihuapp/module/load_more_page.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_bloc.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_event.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_state.dart';
import 'package:url_launcher/url_launcher.dart' as ul;
import '../widget/my_page_view.dart' as mp;
import '../news_data_entity.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class NewsDetailListPage extends BasePage<NewsDetailListPage, NewsBloc> {
  static const String router = Router.baseRoute + 'news/detail';
  mp.PageController _controller;
  final bool isTop;
  final int initIndex;
  String date;

  static launch(
    context, {
    @required bool isTop,
    @required int initIndex,
    String date,
  }) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewsDetailListPage._(
            isTop: isTop,
            initIndex: initIndex,
            date: date,
          ),
        ));
  }

  NewsDetailListPage._({Key key, this.isTop, this.initIndex, this.date})
      : super(key: key, routerName: router);

  @override
  NewsBloc getBLoc({BuildContext context}) =>
      BlocProvider.of<NewsBloc>(context);

  @override
  String get barTile => null;

  @override
  void onCreate(BuildContext context) {

  }

  @override
  void onDestroy(BuildContext context) {}

  List<String> _getDatas(NewsSuccessState state) {
    List<String> datas = List<String>();
    if (isTop) {
      _controller = mp.PageController(initialPage: initIndex);
      for (NewsDataTopStory data in state.topStories) {
        datas.add(data.url);
      }
    } else {
      int cardinal = 0;
      for (NewsDataEntity dataStory in state.datas) {
        if (this.date == dataStory.date) {
          _controller = mp.PageController(initialPage: cardinal+initIndex);
        }
        for (NewsDataStory data in dataStory.stories) {
          cardinal++;
          datas.add(data.url);
        }
      }
    }
    return datas;
  }

  Widget _getTopPageView(List<String> datas) {
    return mp.PageView.builder(
      itemCount: datas.length,
      controller: _controller,
      itemBuilder: (context, index) {
        String url = datas[index];
        return InAppWebView(
          initialUrl: url,
          initialOptions: InAppWebViewWidgetOptions(
            inAppWebViewOptions: InAppWebViewOptions(
              disableHorizontalScroll: true,
              useShouldOverrideUrlLoading: true,
            ),
            androidInAppWebViewOptions: AndroidInAppWebViewOptions(
              mixedContentMode:
                  AndroidInAppWebViewMixedContentMode.fromValue(2),
            ),
          ),
          shouldOverrideUrlLoading: (controller, url) {
//            controller.loadUrl(url: url);
            _launchURL(url);
          },
        );
      },
    );
  }

  Widget _getNotTopPageView(List<String> datas) {
    return mp.PageView.builder(
      itemCount: datas.length + 1,
      controller: _controller,
      itemBuilder: (context, index) {
        if (index == datas.length) {
          return LoadMorPage();
        }
        String url = datas[index];
        return InAppWebView(
          initialUrl: url,
          initialOptions: InAppWebViewWidgetOptions(
            inAppWebViewOptions: InAppWebViewOptions(
              disableHorizontalScroll: true,
              useShouldOverrideUrlLoading: true,
            ),
            androidInAppWebViewOptions: AndroidInAppWebViewOptions(
              mixedContentMode:
                  AndroidInAppWebViewMixedContentMode.fromValue(2),
            ),
          ),
          shouldOverrideUrlLoading: (controller, url) {
//            controller.loadUrl(url: url);
            _launchURL(url);
          },
        );
      },
    );
  }

  _launchURL(url) async {
    if (await ul.canLaunch(url)) {
      await ul.launch(url);
    } else {
      BotToast.showText(text: 'Could not launch $url');
    }
  }

  @override
  Widget getBody(context) {
    return BlocBuilder<NewsBloc, NewsState>(
//      bloc: bloc,
      builder: (context, NewsState state) {
        if (state is NewsSuccessState) {
          List<String> datas = _getDatas(state);
          return isTop ? _getTopPageView(datas) : _getNotTopPageView(datas);
        }
      },
    );
  }
}
