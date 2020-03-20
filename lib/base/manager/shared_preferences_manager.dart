import 'package:shared_preferences/shared_preferences.dart';

///
/// author：wangbufan
/// time: 2020/2/22
/// email: wangbufan00@gmail.com
///

class SPManager{

  static setString(String key,String value) async{
    if(key!=null&&key.isNotEmpty && value!=null){
      SharedPreferences prefs=await SharedPreferences.getInstance();
      return prefs.setString(key, value);
    }
  }

  static Future<String> getString(String key)async{
    String value;
    if(key!=null&&key.isNotEmpty){
      SharedPreferences prefs=await SharedPreferences.getInstance();
      value=prefs.getString(key)??"";
    }
    return value;
  }

  static setInt(String key,int value) async{
    if(key!=null&&key.isNotEmpty ){
      SharedPreferences prefs=await SharedPreferences.getInstance();
      return prefs.setInt(key, value);
    }
  }

  static Future<int> getInt(String key)async{
    int value;
    if(key!=null&&key.isNotEmpty){
      SharedPreferences prefs=await SharedPreferences.getInstance();
      value=prefs.getInt(key)??0;
    }
    return value;
  }


}


