import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackingToast extends StatefulWidget {
  @override
  _StackingToastState createState() => _StackingToastState();
}

class _StackingToastState extends State<StackingToast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StackingToast"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: RaisedButton(
          onPressed: () {
            // https://ant.design/components/message-cn/
            BotToast.showStackingToast(
                title: 'Hello',
                message:
                    'This toast imitates "Message" component of ant design.');
          },
        ),
      ),
    );
  }
}
