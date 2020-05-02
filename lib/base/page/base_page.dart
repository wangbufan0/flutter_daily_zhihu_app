library base;

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../manager/dialog_manager.dart';

///
/// author：wangbufan
/// time: 2020/1/12
/// email: wangbufan00@gmail.com
///

// ignore: must_be_immutable
abstract class BasePage<T extends BasePage<T, B>, B extends Bloc>
    extends StatefulWidget {
  final String routerName;

  BasePage({Key key, this.routerName}) : super(key: key);

  //页面实体
  Widget getBody(BuildContext context);

  //标题，如果置空隐藏标题
  String get barTile;

  //bloc
   B get bloc{
    if(_bloc==null){
      _bloc=getBLoc();
    }
    return _bloc;
   }

   B getBLoc({BuildContext context});

   B _bloc;

  //初始化
  void onCreate(BuildContext context) {}

  //销毁时
  void onDestroy(BuildContext context) {
    bloc?.close();
    _bloc=null;
  }

  //获得标题实体
  Widget getBar(BuildContext context) {
    return barTile == null
        ? null
        : AppBar(
            title: Text(barTile),
          );
  }

  Widget build(BuildContext context) {
    _bloc=getBLoc(context: context);
    return Scaffold(
      appBar: getBar(context),
      body: getBody(context),
    );
  }

  @override
  State createState() => _BasePageState<T, B>();
}

class _BasePageState<T extends BasePage<T, B>, B extends Bloc>
    extends State<T> {
  @override
  void initState() {
    super.initState();
    widget.onCreate(context);
  }

  @override
  void dispose(){
    widget.onDestroy(context);
    if(DialogManager().isShowDialog){
      DialogManager().hideDialog(context);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context);
  }
}
