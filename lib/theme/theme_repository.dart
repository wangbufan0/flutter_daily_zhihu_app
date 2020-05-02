

import 'package:flutterdailyzhihuapp/sp_provider.dart';

///
/// author：wangbufan
/// time: 2020/2/27
/// email: wangbufan00@gmail.com
///

class ThemeRepository{

  static const _ThemeColor='ThemeColor';
  factory ThemeRepository()=>ThemeRepository._();

  ThemeRepository._();

  static Future<int> getThemeColorIndex()async{
    int index= await SPProvider.getInt(_ThemeColor);
    if(index>4)index=4;
    else if(index <0)index=0;
    return index;
  }

  static setThemeColorIndex(int index)async{
    return SPProvider.setInt(_ThemeColor, index);
  }

}


