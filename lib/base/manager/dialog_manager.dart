library base;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// author：wangbufan
/// time: 2020/2/21
/// email: wangbufan00@gmail.com
///

class DialogManager {

  static get incenter=>DialogManager();

  factory DialogManager()=>_dialogManager();

  static DialogManager _instance;

  DialogManager._(){
    _isShowDialog=false;
  }

  static DialogManager _dialogManager(){
    if(_instance==null){
      _instance=DialogManager._();
    }
    return _instance;
  }

  bool _isShowDialog ;

  bool get isShowDialog => _isShowDialog;

  showLoadingDialog(
    BuildContext context,
  ) async {
    if (_isShowDialog == true) {
      print('尝试打开多个Dialog');
      return false;
    }
    _isShowDialog = true;
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            content: Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text('载入中...'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<bool> showConfirmDialog(
    BuildContext context, {
    String title,
    String message,
    String cancelText,
    String confirmText,
    VoidCallback cancelCallback,
    VoidCallback confirmCallback,
  }) async {
    if (_isShowDialog == true) {
      print('尝试打开多个Dialog');
      return false;
    }
    _isShowDialog = true;
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            title: Text(title ?? '是否确认'),
            content: message == null || message.isEmpty ? null : Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(cancelText ?? '取消'),
                onPressed: () {
                  if (cancelCallback == null) {
                    hideDialog(context,result: false);
                  } else {
                    cancelCallback();
                  }
                },
              ),
              CupertinoDialogAction(
                child: Text(cancelText ?? '确认'),
                onPressed: () {
                  if (confirmCallback == null) {
                    hideDialog(context,result: true);
                  } else {
                    confirmCallback();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<bool> showSingleChoiceDialog(
      BuildContext context, {
        String title,
        String message,
        String cancelText,
        String confirmText,
        VoidCallback cancelCallback,
        VoidCallback confirmCallback,
      }) async {
    if (_isShowDialog == true) {
      print('尝试打开多个Dialog');
      return false;
    }
    _isShowDialog = true;
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            title: Text(title ?? '是否确认'),
            content: message == null || message.isEmpty ? null : Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(cancelText ?? '取消'),
                onPressed: () {
                  if (cancelCallback == null) {
                    hideDialog(context,result: false);
                  } else {
                    cancelCallback();
                  }
                },
              ),
              CupertinoDialogAction(
                child: Text(cancelText ?? '确认'),
                onPressed: () {
                  if (confirmCallback == null) {
                    hideDialog(context,result: true);
                  } else {
                    confirmCallback();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }


  hideDialog(
    BuildContext context, {
    Object result,
  }) {
    if (_isShowDialog == false) {
      print('没有在显示的弹窗');
      return;
    }
    _isShowDialog = false;
    Navigator.pop(context,result);
  }
}
