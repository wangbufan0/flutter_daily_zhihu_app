import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix1;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class NewsDetailPage extends StatelessWidget {
  final String url;

  const NewsDetailPage({Key key, this.url}) : super(key: key);

  static launch(context, {String url}) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => NewsDetailPage(
                  url: url,
                ))
//      PageRouteBuilder(
//          transitionDuration: Duration(milliseconds: 200),
//          pageBuilder: (context, animation, secondaryAnimation) {
//            return CupertinoPageTransition(
//              primaryRouteAnimation: animation,
//              secondaryRouteAnimation: secondaryAnimation,
//              child: NewsDetailPage(url: url),
//              linearTransition: false,
//            );
//          }),
        );

//    Navigator.push(context, CupertinoPageRoute(builder: (context) {
//      return NewsDetailPage(
//        url: url,
//      );
//    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        initialUrl: url,
        initialOptions: InAppWebViewWidgetOptions(
          inAppWebViewOptions: InAppWebViewOptions(
            debuggingEnabled: true,
            disableHorizontalScroll: true,
          ),
          androidInAppWebViewOptions: AndroidInAppWebViewOptions(
            mixedContentMode: AndroidInAppWebViewMixedContentMode.fromValue(0)
          )
        ),
      ),
    );
  }
}
