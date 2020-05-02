import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_event.dart';
import 'package:flutterdailyzhihuapp/news_bloc/news_state.dart';
import 'package:flutterdailyzhihuapp/news_provider.dart';
import 'package:flutterdailyzhihuapp/sp_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../news_data_entity.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  @override
  // TODO: implement initialState
  NewsState get initialState => NewsInitialState();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is NewsInitEvent) {
      yield NewsInitialState();
//      NewsDataEntity data = await NewsProvider.getNews();
      NewsDataEntity data = await SPProvider.getDatas();
      if (data!=null&&data.topStories.isNotEmpty && data.stories.isNotEmpty) {
        yield NewsSuccessState(
          topStories: data.topStories,
          datas: List<NewsDataEntity>()..add(data),
        );
      } else {
        add(NewsRefreshEvent());
      }
    } else if (event is NewsRefreshEvent) {
      NewsDataEntity data = await NewsProvider.getNews();
      SPProvider.setDatas(data);
      if (data != null) {
        yield NewsSuccessState(
          topStories: data.topStories,
          datas: List<NewsDataEntity>()..add(data),
        );
      }
    } else if (event is NewsLoadMoreEvent) {
      NewsState lastState = state;
      if (lastState is NewsSuccessState) {
        String before = lastState.datas.last.date;
        NewsDataEntity data = await NewsProvider.getNews(
          before: before,
        );
        if (data != null) {
          data.topStories = null;
          yield lastState.addData(data);
        }
      } else {
        yield NewsErrorState();
      }
    }
  }
}
