import 'package:equatable/equatable.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///


///1.page_start 2. refresh 3. loading_more
abstract class BaseListEvent extends Equatable {}

class BaseListInitEvent extends BaseListEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BaseListErrorEvent extends BaseListEvent {
  final String error;

  BaseListErrorEvent({this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class BaseListRefreshEvent<D> extends BaseListEvent {
  final List<D> data;

  BaseListRefreshEvent({this.data});

  @override
  // TODO: implement props
  List<Object> get props => data;
}

class BaseListLoadMoreEvent<D> extends BaseListEvent {
  final List<D> data;

  BaseListLoadMoreEvent({this.data});

  @override
  // TODO: implement props
  List<Object> get props => data;
}
