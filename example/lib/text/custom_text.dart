import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  int seconds = 2;
  bool crossPage = true;
  bool clickClose = false;
  bool ignoreContentClick = false;
  bool onlyOne = true;
  int backgroundColor = 0x00000000;
  int animationMilliseconds = 200;
  int animationReverseMilliseconds = 200;
  BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CustomText"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  BotToast.showCustomText(
                    duration: Duration(seconds: seconds),
                    onlyOne: onlyOne,
                    clickClose: clickClose,
                    crossPage: crossPage,
                    ignoreContentClick: ignoreContentClick,
                    backgroundColor: Color(backgroundColor),
                    backButtonBehavior: backButtonBehavior,
                    animationDuration:
                        Duration(milliseconds: animationMilliseconds),
                    animationReverseDuration:
                        Duration(milliseconds: animationReverseMilliseconds),
                    toastBuilder: (_) => Align(
                      alignment: Alignment(0, 0.8),
                      child: Card(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: Colors.redAccent,
                                ),
                                onPressed: () {
                                  BotToast.showSimpleNotification(
                                      title: "Yes, I do!",
                                      crossPage: crossPage,
                                      closeIcon: Icon(
                                        Icons.favorite,
                                        color: Colors.redAccent,
                                      ),
                                      duration: Duration(seconds: seconds));
                                }),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text("propose marriage?"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Text("TextToast"),
              ),
              ListTile(
                title: Text("duration:   ${seconds}s"),
                trailing: CupertinoSlider(
                  min: 1,
                  max: 20,
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
              Center(child: Text('BackButtonBehavior'),),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(value: BackButtonBehavior.none,
                      groupValue: backButtonBehavior,
                      onChanged: (value) {
                        setState(() {
                          backButtonBehavior = value;
                        });
                      },
                      title: Text('none'),),
                  ),
                  Expanded(
                    child: RadioListTile(value: BackButtonBehavior.ignore,
                      groupValue: backButtonBehavior,
                      onChanged: (value) {
                        setState(() {
                          backButtonBehavior = value;
                        });
                      },
                      title: Text('ignore'),),
                  ),
                  Expanded(
                    child: RadioListTile(value: BackButtonBehavior.close,
                      groupValue: backButtonBehavior,
                      onChanged: (value) {
                        setState(() {
                          backButtonBehavior = value;
                        });
                      },
                      title: Text('close'),),
                  )
                ],
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
                value: clickClose,
                onChanged: (value) {
                  setState(() {
                    clickClose = value;
                  });
                },
                title: Text("clickClose: "),
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
              SwitchListTile(
                value: ignoreContentClick,
                onChanged: (value) {
                  setState(() {
                    ignoreContentClick = value;
                  });
                },
                title: Text("ignoreContentClick: "),
              ),


              ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(child: Text("backgroundColor:")),
                    Container(
                      height: 20,
                      width: 20,
                      color: Color(backgroundColor),
                    )
                  ],
                ),
                trailing: CupertinoSlider(
                  min: 0x00000000,
                  max: 0xffffffff,
                  value: backgroundColor.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      backgroundColor = value.toInt();
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
