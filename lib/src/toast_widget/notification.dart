import 'package:flutter/material.dart';

//通知Toast的Widget
class NotificationToast extends StatefulWidget {
  final Widget child;

  final Function? slideOffFunc;

  final List<DismissDirection>? dismissDirections;

  const NotificationToast(
      {Key? key,
      required this.child,
      this.slideOffFunc,
      this.dismissDirections})
      : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
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

    if (widget.slideOffFunc != null &&
        widget.dismissDirections != null &&
        widget.dismissDirections!.isNotEmpty) {
      widget.dismissDirections!.forEach((direction) {
        child = Dismissible(
          direction: direction,
          key: key,
          confirmDismiss: confirmDismiss,
          child: child,
        );
      });
    }

    return child;
  }
}
