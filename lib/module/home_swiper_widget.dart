import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutterdailyzhihuapp/module/news_detail_list_page.dart';
import 'package:flutterdailyzhihuapp/module/news_detail_page.dart';
import 'package:flutterdailyzhihuapp/widget/swiper_widget.dart';
import '../news_data_entity.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class HomeSwiperWidget extends StatelessWidget {
  final List<NewsDataTopStory> topStories;

  const HomeSwiperWidget({Key key, this.topStories}) : super(key: key);

  Widget _getBackground(String imageHue) {
    String colorStr = imageHue.replaceAll('0x', '');
    colorStr = 'FF' + colorStr;
    Color color = Color(
      int.parse(
        colorStr,
        radix: 16,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, color],
          begin: Alignment.topRight,
        ),
      ),
    );
  }

  Widget _getTitle(String title, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: SizedBox(
            child: Text(
              title,
              textScaleFactor: 1.65,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            left: 20,
          ),
          child: Text(
            hint,
            style: TextStyle(
              color: Colors.grey[400],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: SwipeWidget<NewsDataTopStory>(
        datas: topStories,
        itemBuilder: (context, data) {
          return GestureDetector(
            onTap: () {
//              NewsDetailPage.launch(
//                context,
//                url: data.url,
//              );
              NewsDetailListPage.launch(
                context,
                isTop: true,
                initIndex: topStories.indexOf(data),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  data.image,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: _getBackground(data.imageHue),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _getTitle(data.title, data.hint),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
