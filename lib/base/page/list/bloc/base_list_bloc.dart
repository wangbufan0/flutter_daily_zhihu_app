import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './base_list_event.dart';
import './base_list_state.dart';
export './base_list_event.dart';
export './base_list_state.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class BaseListBloc<D> extends Bloc<BaseListEvent,BaseListState> {


  @override
  // TODO: implement initialState
  BaseListState get initialState => BaseListLoadingState();

  @override
  Stream<BaseListState> mapEventToState(BaseListEvent event)async* {
    if(event is BaseListInitEvent){
      yield BaseListLoadingState();
    }else if(event is BaseListErrorEvent){
      yield BaseListErrorState(error:event.error);
    }else if(event is BaseListRefreshEvent<D>){
      yield BaseListSuccessState<D>(datas :event.data);
    }else if(event is BaseListLoadMoreEvent<D>){
      if(state is BaseListSuccessState<D>){
        List<D> data=event.data;
        List<D> datas=(state as BaseListSuccessState<D>).datas;
        yield BaseListSuccessState<D>(datas :List<D>()..addAll(datas)..addAll(data));
      }else{
        yield BaseListErrorState(error:'不是一个适合刷新的场景');
      }
    }
  }
}