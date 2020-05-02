import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutterdailyzhihuapp/theme/bloc/theme_state.dart';

import '../theme_repository.dart';

///
/// author：wangbufan
/// time: 2020/2/22
/// email: wangbufan00@gmail.com
///

enum ThemeEvent{
  blue,
  cyan,
  teal,
  green,
  red,
}
const ThemeColor = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{

  ThemeBloc(){
    initTheme();
  }

  initTheme()async{
    int index= await ThemeRepository.getThemeColorIndex();
    add(ThemeEvent.values[index]);
  }

  @override
  ThemeState get initialState => ThemeState.initial();

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event)async* {
    await ThemeRepository.setThemeColorIndex(event.index);
    yield ThemeState(ThemeColor[event.index]);
  }

}




