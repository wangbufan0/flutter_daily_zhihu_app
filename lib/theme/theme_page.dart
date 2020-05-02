import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterdailyzhihuapp/base/page/base_page.dart';
import 'package:flutterdailyzhihuapp/base/router.dart';

import 'bloc/theme_bloc.dart';
import 'bloc/theme_state.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///

class ThemePage extends BasePage<ThemePage, ThemeBloc> {
  static const String router = Router.baseRoute + 'theme';

  ThemePage({Key key}) : super(key: key, routerName: router);

  static WidgetBuilder builder = (context) {
    return ThemePage();
  };

  @override
  String get barTile => 'theme';

  static const _ThemeString = <String>[
    'blue',
    'cyan',
    'teal',
    'green',
    'red',
    'white'
  ];

  Widget getCheckbox({int index, int checkIndex, context}) {
    return InkWell(
      onTap: () {
        if (index != checkIndex) {
          BlocProvider.of<ThemeBloc>(context).add(ThemeEvent.values[index]);
        }
      },
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: ThemeColor[index],
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
              Text(_ThemeString[index]),
              Expanded(
                child: Container(),
              ),
              Container(
                padding: EdgeInsets.all(18.0),
                child: index == checkIndex
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                      )
                    : null,
              ),
            ],
          ),
          Container(
            height: 1,
            color: Colors.grey,
          )
        ],
      ),
    );
  }

  @override
  Widget getBody(context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, ThemeState state) {
        int checkIndex = ThemeColor.indexOf(state.themeColor);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              getCheckbox(
                index: 0,
                checkIndex: checkIndex,
                context: context,
              ),
              getCheckbox(
                index: 1,
                checkIndex: checkIndex,
                context: context,
              ),
              getCheckbox(
                index: 2,
                checkIndex: checkIndex,
                context: context,
              ),
              getCheckbox(
                index: 3,
                checkIndex: checkIndex,
                context: context,
              ),
              getCheckbox(
                index: 4,
                checkIndex: checkIndex,
                context: context,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  ThemeBloc getBLoc({BuildContext context}) {
    // TODO: implement getBLoc
    return null;
  }
}
