import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///Toast的关闭函数,调用将会提前关闭对应的Toast
typedef CancelFunc = void Function();
typedef ToastBuilder = Widget Function(CancelFunc cancelFunc);
typedef FutureFunc = Future<void> Function();
typedef PopTestFunc = bool Function();

typedef WrapWidget = Widget Function(CancelFunc cancelFunc, Widget widget);
typedef WrapAnimation = Widget Function(AnimationController controller, CancelFunc cancelFunc, Widget widget);

class TickerProviderImpl extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

///此枚举会决定Toast对于物理返回键的处理方式
class BackButtonBehavior {
  ///不做任何处理

  static const BackButtonBehavior none = BackButtonBehavior(0, 'none');

  ///拦截此次点击事件
  static const BackButtonBehavior ignore = BackButtonBehavior(1, 'ignore');

  ///拦截此次点击事件,并把Toast关闭
  static const BackButtonBehavior close = BackButtonBehavior(2, 'close');

  const BackButtonBehavior(this.index, this.name);

  final int index;
  final String name;

  @override
  String toString() {
    return 'BackButtonBehavior.$name';
  }
}

//请不要调整顺序!!
//前面是主方向,后面是对齐比如
//topLeft,就是希望在上面,并且左对齐目标
class PreferDirection {
  static const PreferDirection topLeft = PreferDirection(0, 'topLeft');
  static const PreferDirection topCenter = PreferDirection(1, 'topCenter');
  static const PreferDirection topRight = PreferDirection(2, 'topRight');
  static const PreferDirection bottomLeft = PreferDirection(3, 'bottomLeft');
  static const PreferDirection bottomCenter = PreferDirection(4, 'bottomCenter');
  static const PreferDirection bottomRight = PreferDirection(5, 'bottomRight');
  static const PreferDirection leftTop = PreferDirection(6, 'leftTop');
  static const PreferDirection leftCenter = PreferDirection(7, 'leftCenter');
  static const PreferDirection leftBottom = PreferDirection(8, 'leftBottom');
  static const PreferDirection rightTop = PreferDirection(9, 'rightTop');
  static const PreferDirection rightCenter = PreferDirection(10, 'rightCenter');
  static const PreferDirection rightBottom = PreferDirection(11, 'rightBottom');

  const PreferDirection(this.index, this.name);

  final int index;
  final String name;

  @override
  String toString() {
    return 'PreferDirection.$name';
  }
}
