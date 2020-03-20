import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterdailyzhihuapp/base/request.dart';
import 'package:flutterdailyzhihuapp/news_data_entity.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class NewsProvider {
  static Future<NewsDataEntity> getNews({String before}) async {
    String url = before != null ? 'before/$before' : 'latest';
    ResultData result = await Request.get(
      url: url,
    );
    NewsDataEntity datas;
    if(result.result){
      datas=NewsDataEntity().fromJson(result.data);
    }else{
//      throw Error();
      BotToast.showText(text: '发生了一些错误:${result.data.toString()}');
    }
//    print(datas.toJson());
    return datas;
  }
}
