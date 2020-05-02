import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_bloc.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_event.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class LoadMorPage extends StatefulWidget{


  @override
  State createState() {
    return _LoadMorePageStete();
  }
}
class _LoadMorePageStete extends State<LoadMorPage>{

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(NewsLoadMoreEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

