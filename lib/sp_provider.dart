import 'dart:convert';

import 'package:flutterdailyzhihuapp/news_data_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class SPProvider {
  static String pathName = 'zhihuDailySp';

  static setDatas(NewsDataEntity datas) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(pathName, jsonEncode(datas));
    return;
  }

  static Future<NewsDataEntity> getDatas() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String jsString =sp.getString(pathName)??"";
    if(jsString.isEmpty)return null;
    return NewsDataEntity().fromJson(jsonDecode(jsString));
  }

  static Future setInt(String key,int value)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setInt(key, value);
    return;
  }

  static Future<int> getInt(String key)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(key)??0;
  }
}
