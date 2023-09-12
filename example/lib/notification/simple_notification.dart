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
  BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;

  @override
  void initState() {
    ///全局范围内将标准通知的动画时间修改为 1 秒
    BotToast.defaultOption.notification.animationDuration=const Duration(seconds: 1);
    BotToast.showSimpleNotification(
        title: "Notification title",
        subTitle: "Notification subtitle",
        enableSlideOff: enableSlideOff,
        hideCloseButton: hideCloseButton,
        onTap: () {
          BotToast.showText(text: 'Tap toast');
        },
        onLongPress: () {
          BotToast.showText(text: 'Long press toast');
        },
        backgroundColor: Colors.red,
        titleStyle: const TextStyle(color: Colors.white),
        subTitleStyle: const TextStyle(color: Colors.white),
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
        title: const Text("SimpleNotification"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  BotToast.showSimpleNotification(
                      title: "Notification title",
                      subTitle: "Notification subtitle",
                      enableSlideOff: enableSlideOff,
                      hideCloseButton: hideCloseButton,
                      onlyOne: onlyOne,
                      crossPage: crossPage,
                      backButtonBehavior: backButtonBehavior,
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
                child: const Text("simpleNotification"),
              ),
              SwitchListTile(
                value: enableSlideOff,
                onChanged: (bool value) {
                  setState(() {
                    enableSlideOff = value;
                  });
                },
                title: const Text("enableSlideOff: "),
              ),
              SwitchListTile(
                value: hideCloseButton,
                onChanged: (bool value) {
                  setState(() {
                    hideCloseButton = value;
                  });
                },
                title: const Text("hideCloseButton: "),
              ),
              SwitchListTile(
                value: onlyOne,
                onChanged: (bool value) {
                  setState(() {
                    onlyOne = value;
                  });
                },
                title: const Text("onlyOne: "),
              ),
              SwitchListTile(
                value: crossPage,
                onChanged: (bool value) {
                  setState(() {
                    crossPage = value;
                  });
                },
                title: const Text("crossPage: "),
              ),
              const Center(
                child: Text('BackButtonBehavior'),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(
                      value: BackButtonBehavior.none,
                      groupValue: backButtonBehavior,
                      onChanged: (BackButtonBehavior? value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('none'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: BackButtonBehavior.ignore,
                      groupValue: backButtonBehavior,
                      onChanged: (BackButtonBehavior? value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('ignore'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: BackButtonBehavior.close,
                      groupValue: backButtonBehavior,
                      onChanged: (BackButtonBehavior? value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('close'),
                    ),
                  )
                ],
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
            ],
          ),
        ),
      ),
    );
  }
}
