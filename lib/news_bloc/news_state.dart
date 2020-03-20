import 'package:equatable/equatable.dart';

import '../news_data_entity.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

abstract class NewsState extends Equatable {}

class NewsInitialState extends NewsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NewsErrorState extends NewsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NewsSuccessState extends NewsState {
  final List<NewsDataTopStory> topStories;
  final List<NewsDataEntity> datas;

  NewsSuccessState({this.topStories, this.datas});

  @override
  // TODO: implement props
  List<Object> get props => datas;

  NewsSuccessState addData(NewsDataEntity data) {
    return NewsSuccessState(
      topStories: this.topStories,
      datas: List<NewsDataEntity>()
        ..addAll(datas)
        ..add(data),
    );
  }
}
