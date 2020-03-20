import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterdailyzhihuapp/base/page/list/base_list_page.dart';
import 'package:flutterdailyzhihuapp/base/router.dart';

///
/// author：wangbufan
/// time: 2020/2/21
/// email: wangbufan00@gmail.com
///

class HomeListPage extends BaseListPage<int> {
  static const String router = Router.baseRoute + 'home';

  HomeListPage({Key key}) : super(key: key, router: router);

  @override
  String get barTile => 'home';

  @override
  Widget getListTitle(int data) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text(data.toString()),
      ),
    );
  }

  Widget getSwiper() {
    return Swiper(
      itemBuilder: (context, index) {
        return Image.network(
          "http://via.placeholder.com/350x150",
          fit: BoxFit.fill,
        );
      },
      itemCount: 5,
      pagination: SwiperPagination(),
      autoplay: true,
    );
  }

  @override
  Widget getList(List<int> datas) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: SizedBox(
            height: 250,
            child: getSwiper(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return getListTitle(datas[index]);
            },
            childCount: datas.length,
          ),
//          itemExtent: 50,
        ),
      ],
    );
  }

  @override
  Future<List<int>> loadData(int page) async {
    var data;
    if (page <= 3) {
      data = List<int>();
      int m = (page - 1) * 10;
      for (int i = 0; i < 10; i++) {
        data.add(m + i);
      }
    }
    await Future.delayed(Duration(seconds: 2));
    return data;
  }
}
