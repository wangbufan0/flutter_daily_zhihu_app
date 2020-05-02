///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class StringUtil{

  // ignore: non_constant_identifier_names
  static String String2Date(String s){
    String month=s.substring(4,6);
    String day=s.substring(6,8);
    return month+'月'+day+'日';
  }


}
