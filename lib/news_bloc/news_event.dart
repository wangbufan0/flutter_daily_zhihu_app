import 'package:equatable/equatable.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

abstract class NewsEvent extends Equatable{}

class NewsInitEvent extends NewsEvent{

  @override
  // TODO: implement props
  List<Object> get props => [];
}
class NewsRefreshEvent extends NewsEvent{

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class NewsLoadMoreEvent extends NewsEvent{

  @override
  // TODO: implement props
  List<Object> get props => [];
}