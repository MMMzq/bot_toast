import 'dart:ui';

import 'package:flutter/material.dart';


//该类是基于自己的size充满整个屏幕下的情况使用的,
//或者说是自己offset距离屏幕顶部为0的下使用的
class KeyBoardSafeArea extends StatelessWidget {

  final Widget child ;

  const KeyBoardSafeArea({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData data= MediaQuery.of(context,nullOk: true);
    return Padding(
      padding: EdgeInsets.only(bottom: (data!=null?data.viewInsets.bottom:0.0)),
      child: child,
    );
  }
}

