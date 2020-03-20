import 'package:equatable/equatable.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///


///1. loading 2. error 3. success
abstract class BaseListState extends Equatable {}


class BaseListLoadingState extends BaseListState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class BaseListErrorState extends BaseListState {
  final String error;

  BaseListErrorState({this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class BaseListSuccessState<D> extends BaseListState {
  final List<D> datas;

  BaseListSuccessState({this.datas});

  @override
  // TODO: implement props
  List<Object> get props => datas;
}