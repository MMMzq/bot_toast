import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bot_toast/bot_toast.dart';

class SimpleNotification extends StatefulWidget {
  @override
  _SimpleNotificationState createState() => _SimpleNotificationState();
}

class _SimpleNotificationState extends State<SimpleNotification> {
  bool enableSlideOff = true;
  bool hideCloseButton = false;
  bool onlyOne = true;
  bool crossPage = true;
  int seconds = 2;
  int animationMilliseconds = 200;
  int animationReverseMilliseconds = 200;

  @override
  void initState() {
    BotToast.showSimpleNotification(
        title: "do you still love me ?",
        subTitle: "yes!",
        enableSlideOff: enableSlideOff,
        hideCloseButton: hideCloseButton,
        onTap: () {
          BotToast.showText(text: 'Tap toast');
        },
        onLongPress: () {
          BotToast.showText(text: 'Long press toast');
        },
        onlyOne: onlyOne,
        crossPage: crossPage,
        animationDuration: Duration(milliseconds: animationMilliseconds),
        animationReverseDuration:
            Duration(milliseconds: animationReverseMilliseconds),
        duration: Duration(seconds: seconds));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SimpleNotification"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  BotToast.showSimpleNotification(
                      title: "do you still love me ?",
                      subTitle: "yes!",
                      enableSlideOff: enableSlideOff,
                      hideCloseButton: hideCloseButton,
                      onlyOne: onlyOne,
                      crossPage: crossPage,
                      onTap: () {
                        BotToast.showText(text: 'Tap toast');
                      },
                      onLongPress: () {
                        BotToast.showText(text: 'Long press toast');
                      },
                      animationDuration:
                          Duration(milliseconds: animationMilliseconds),
                      animationReverseDuration:
                          Duration(milliseconds: animationReverseMilliseconds),
                      duration: Duration(seconds: seconds));
                },
                child: Text("simpleNotification"),
              ),
              SwitchListTile(
                value: enableSlideOff,
                onChanged: (value) {
                  setState(() {
                    enableSlideOff = value;
                  });
                },
                title: Text("enableSlideOff: "),
              ),
              SwitchListTile(
                value: hideCloseButton,
                onChanged: (value) {
                  setState(() {
                    hideCloseButton = value;
                  });
                },
                title: Text("hideCloseButton: "),
              ),
              SwitchListTile(
                value: onlyOne,
                onChanged: (value) {
                  setState(() {
                    onlyOne = value;
                  });
                },
                title: Text("onlyOne: "),
              ),
              SwitchListTile(
                value: crossPage,
                onChanged: (value) {
                  setState(() {
                    crossPage = value;
                  });
                },
                title: Text("crossPage: "),
              ),
              ListTile(
                title: Text("duration:   ${seconds}s"),
                trailing: CupertinoSlider(
                  min: 1,
                  max: 20,
                  divisions: 20,
                  value: seconds.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      seconds = value.toInt();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("animationDuration:   ${animationMilliseconds}ms"),
                trailing: CupertinoSlider(
                  min: 100,
                  max: 1000,
                  divisions: 18,
                  value: animationMilliseconds.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      animationMilliseconds = value.toInt();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text(
                    "animationReverseDuration:   ${animationReverseMilliseconds}ms"),
                trailing: CupertinoSlider(
                  min: 100,
                  max: 1000,
                  divisions: 18,
                  value: animationReverseMilliseconds.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      animationReverseMilliseconds = value.toInt();
                    });
                  },
                ),
              ),
              Divider(),
              Text("code"),
              Divider(),
              Text(
                _code,
                textAlign: TextAlign.start,
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

String _code = """
BotToast.showSimpleNotification(
    title: "do you still love me ?",
    subTitle: "yes!",
    enableSlideOff: enableSlideOff,
    hideCloseButton: hideCloseButton,
    onlyOne: onlyOne,
    crossPage: crossPage,
    duration: Duration(seconds: seconds));
""";
