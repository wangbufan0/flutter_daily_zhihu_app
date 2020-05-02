import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// author：wangbufan
/// time: 2020/2/28
/// email: wangbufan00@gmail.com
///
typedef IndexedWidgetBuilder<D> = Widget Function(
    BuildContext context, D data);

class SwipeWidget<D> extends StatefulWidget {
  final IndexedWidgetBuilder<D> itemBuilder;
  final List<D> datas;

  const SwipeWidget({Key key, @required this.itemBuilder, @required this.datas})
      : super(key: key);

  @override
  State createState() => _SwipeWidgetState<D>();
}

class _SwipeWidgetState<D> extends State<SwipeWidget<D>> {
  final PageController _controller = PageController(initialPage: 200);
  final StreamController<double> _pageStream = StreamController();
  Timer autoNext;

  @override
  void initState() {
    super.initState();
    _startNext();
    _controller.addListener(() {
      _pageStream.add(_controller.page);
      if (autoNext == null &&
          _controller.page - _controller.page.truncate() == 0) {
        _startNext();
      }
    });
  }

  @override
  void dispose() {
    _pageStream.close();
    _stopNext();
    super.dispose();
  }

  void _startNext() {
    if (autoNext != null) {
      autoNext.cancel();
    }
    autoNext = Timer.periodic(
      Duration(milliseconds: 3000),
      (timer) {
        _controller.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      },
    );
  }

  void _stopNext() {
    if (autoNext != null) {
      autoNext.cancel();
    }
    autoNext = null;
  }

  static Widget _point=Container(
    height: 4,
    width: 4,
    margin: EdgeInsets.all(3),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(2),
      color: Colors.grey[400],
    ),
  );

  Widget _getPoint(double page) {
    int itemCount = widget.datas.length;
    int activeIndex = page.truncate() % itemCount;
    double decimal = page - page.truncate();
    double right = decimal * (20 - 4);
    double left = 16.0 - right;
    List<Widget> children = List<Widget>();
    for (int i = 0; i < itemCount; i++) {
      children.add(_point);
    }
    children[activeIndex] = Container(
      height: 4,
      width: 4 + left,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color.lerp(
          Colors.grey[400],
          Colors.grey[50],
          1 - decimal,
        ),
      ),
    );
    children[(activeIndex + 1) % itemCount] = Container(
      height: 4,
      width: 4 + right,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Color.lerp(
          Colors.grey[400],
          Colors.grey[50],
          decimal,
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(
        right: 20,
        bottom: 15,
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onPanDown: (_) {
            _stopNext();
          },
          child: PageView.builder(
            controller: _controller,
            itemBuilder: (context, index) {
              return widget.itemBuilder(
                  context, widget.datas[index % widget.datas.length]);
            },
          ),
        ),
        StreamBuilder(
          stream: _pageStream.stream,
          initialData: 200.0,
          builder: (context, snapshot) {
            return _getPoint(snapshot.data);
          },
        ),
      ],
    );
  }
}
