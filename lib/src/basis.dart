import 'package:flutter/material.dart';

typedef CancelFunc = void Function();
typedef ToastBuilder = Widget Function(CancelFunc cancelFunc);
typedef WrapWidget = Widget Function(Widget widget);

//请不要调整顺序!!
//前面是主方向,后面是对齐比如
//topLeft,就是希望在上面,并且左对齐目标
enum PreferDirection {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
  leftTop,
  leftCenter,
  leftBottom,
  rightTop,
  rightCenter,
  rightBottom,

  ///废弃,改用表达更清晰的bottomCenter,和bottomCenter效果完全一致
  ///在下个大版本将会删除
  @deprecated
  Below,

  ///废弃,改用表达更清晰的topCenter,和topCenter效果完全一致
  ///在下个大版本将会删除
  @deprecated
  Upside
}
