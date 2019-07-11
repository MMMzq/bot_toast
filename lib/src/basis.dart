import 'package:flutter/material.dart';

typedef CancelFunc = void Function();
typedef ToastBuilder = Widget Function(CancelFunc cancelFunc);
typedef WrapWidget = Widget Function(Widget widget);

enum PreferDirection{
  Below,
  Upside
}