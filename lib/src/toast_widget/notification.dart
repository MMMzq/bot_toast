import 'package:flutter/material.dart';

//通知Toast的Widget
class NotificationToast extends StatefulWidget {
  final Widget child;

  final Function? slideOffFunc;

  final List<DismissDirection>? dismissDirections;

  const NotificationToast({required this.child, Key? key, this.slideOffFunc, this.dismissDirections}) : super(key: key);

  @override
  State<NotificationToast> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationToast> {
  Future<bool> confirmDismiss(DismissDirection direction) async {
    widget.slideOffFunc?.call();
    return true;
  }

  Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    if (widget.slideOffFunc != null && widget.dismissDirections != null && widget.dismissDirections!.isNotEmpty) {
      for (DismissDirection direction in widget.dismissDirections!) {
        child = Dismissible(
          direction: direction,
          key: key,
          confirmDismiss: confirmDismiss,
          child: child,
        );
      }
    }

    return child;
  }
}
