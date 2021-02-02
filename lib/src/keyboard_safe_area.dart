import 'package:flutter/material.dart';

//该类是基于自己offset距离屏幕底部为0的下使用的
class KeyboardSafeArea extends StatelessWidget {
  final Widget child;

  final bool enable;

  const KeyboardSafeArea({Key? key,required this.child,required this.enable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!enable) {
      return child;
    }
    MediaQueryData data = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: data.viewInsets.bottom),
      child: child,
    );
  }
}
