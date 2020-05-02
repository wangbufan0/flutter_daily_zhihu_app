import 'package:flutter/cupertino.dart';
import 'package:flutterdailyzhihuapp/module/news_list_page.dart';
import 'package:flutterdailyzhihuapp/theme/theme_page.dart';
///
/// author：wangbufan
/// time: 2020/2/20
/// email: wangbufan00@gmail.com
///

class Router{

  static const String baseRoute='router://app.daily.zhihu.com/';

  static Map<String,WidgetBuilder> routes={
    NewsListPage.router:(context)=>NewsListPage(),
    ThemePage.router:ThemePage.builder,
  };

}


