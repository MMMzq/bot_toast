import 'package:flutter/material.dart';

import 'toast.dart';

class BotToastInit extends StatefulWidget {

  final Widget child;

  const BotToastInit({Key key, this.child}) : super(key: key);

  @override
  _BotToastInitState createState() => _BotToastInitState();
}

class _BotToastInitState extends State<BotToastInit> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    BotToast.init(context);
    super.initState();
  }

  @override
  void didUpdateWidget(BotToastInit oldWidget) {
    BotToast.init(context);
    super.didUpdateWidget(oldWidget);
  }
}
