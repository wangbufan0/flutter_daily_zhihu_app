library base;

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'bloc/base_list_bloc.dart';
import '../base_page.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

// ignore: must_be_immutable
abstract class BaseListPage<D>
    extends BasePage<BaseListPage<D>, BaseListBloc<D>> {
  final bool canRefresh;
  final bool canLoadingMore;

  BaseListPage({
    Key key,
    String router,
    this.canRefresh=true,
    this.canLoadingMore=true,
  }) : super(key: key, routerName: router);

  int page = 1;

  Future<List<D>> loadData(int page);

  @override
  BaseListBloc<D> getBLoc({BuildContext context}) => BaseListBloc<D>();

  _getData({@required isRefresh}) async {
    try {
      if (isRefresh) {
        List<D> data = await loadData(1);
        if (data == null && data.isEmpty) {
          throw Error();
        }
        bloc.add(BaseListRefreshEvent<D>(data: data));
        page = 2;
      } else {
        List<D> data = await loadData(page);
        if (data != null && data.isNotEmpty) {
          bloc.add(BaseListLoadMoreEvent<D>(data: data));
          page++;
        } else {
          BotToast.showText(text: '没有新数据了，上拉重试。');
        }
      }
    } catch (error) {
      bloc.add(BaseListErrorEvent(error: error.toString()));
    }
  }

  //加载失败界面
  Widget getErrorWidget(String error) {
    return Container(
//      color: Colors.deepOrange,
      child: InkWell(
        onTap: () {
          _getData(isRefresh: true);
          bloc.add(BaseListInitEvent());
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('出现了一些错误，点击重试，错误如下：'),
              Text('Error occured: $error'),
            ],
          ),
        ),
      ),
    );
  }

  //加载空界面
  Widget getLoadingWidget() {
    return Container(
//      color: Colors.deepOrange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Text('载入中...'),
            ),
          ],
        ),
      ),
    );
  }

  Widget getListTitle(D data);

  Widget getList(List<D> datas) {
    return ListView(
      children: datas.map((data) {
        return getListTitle(data);
      }).toList(),
    );
  }

  Future onRefresh() async {
    await _getData(isRefresh: true);
    return;
  }

  Future onLoading() async {
    await _getData(isRefresh: false);
    return;
  }

  @override
  void onCreate(context) {
    _getData(isRefresh: true);
  }

  @override
  Widget getBody(context) {
    return BlocBuilder<BaseListBloc<D>, BaseListState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is BaseListLoadingState) {
          return getLoadingWidget();
        } else if (state is BaseListErrorState) {
          return getErrorWidget(state.error);
        } else if (state is BaseListSuccessState<D>) {
          return EasyRefresh(
            header: MaterialHeader(),
            footer: MaterialFooter(),
            onRefresh: canRefresh?onRefresh:null,
            onLoad: canLoadingMore?onLoading:null,
            child: getList(state.datas),
          );
        }
        return getErrorWidget('不可能出现的错误');
      },
    );
  }
}
