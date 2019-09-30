
import 'package:flutter/material.dart';


//通知Toast的Widget
class NotificationToast extends StatefulWidget {
  final Widget child;

  final Function slideOffFunc;

  const NotificationToast(
      {Key key, @required this.child, @required this.slideOffFunc})
      : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<NotificationToast> {
  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    if (widget.slideOffFunc != null) {
      child = Dismissible(
        confirmDismiss: (_) async {
          widget.slideOffFunc();
          return true;
        },
        child: child,
        key: UniqueKey(),
      );
    }

    return child;
  }
}