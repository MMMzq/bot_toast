import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bot_toast/bot_toast.dart';

class AttachedToast extends StatefulWidget {
  @override
  _AttachedToastState createState() => _AttachedToastState();
}

class _AttachedToastState extends State<AttachedToast> {
  // BuildContext targetContext;
  // Offset target;
  double verticalOffset = 0;
  double horizontalOffset = 0;
  int second = 4;
  PreferDirection preferDirection = PreferDirection.topCenter;
  bool ignoreContentClick = false;
  bool onlyOne = true;
  bool allowClick = true;
  bool enableSafeArea = true;
  int backgroundColor = 0x00000000;
  int animationMilliseconds = 200;
  int animationReverseMilliseconds = 200;

  double buttonAlign = 0;

  CancelFunc show({BuildContext? context, Offset? target}) {
    return BotToast.showAttachedWidget(
        target: target,
        targetContext: context,
        verticalOffset: verticalOffset,
        horizontalOffset: horizontalOffset,
        duration: Duration(seconds: second),
        animationDuration:
        Duration(milliseconds: animationMilliseconds),
        animationReverseDuration:
        Duration(milliseconds: animationReverseMilliseconds),
        preferDirection: preferDirection,
        ignoreContentClick: ignoreContentClick,
        onlyOne: onlyOne,
        allowClick: allowClick,
        enableSafeArea: enableSafeArea,
        backgroundColor: Color(backgroundColor),
        attachedBuilder: (cancel) => (Card(
          color: Colors.amber,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                      ),
                      onPressed: () {
                        BotToast.showSimpleNotification(title: "Tap favorite");
                      },
                      label: const Text("favorite"),
                      icon: const Icon(Icons.favorite, color: Colors.redAccent),
                    ),
                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                      ),
                      onPressed: () {
                        BotToast.showSimpleNotification(title: "Tap bookmark");
                      },
                      label: const Text("bookmark"),
                      icon: const Icon(Icons.bookmark,color: Colors.redAccent),
                    )                  ],
                ),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AttachedToast"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTapDown: (TapDownDetails details) {
                  show(target: details.globalPosition);
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  color: Colors.black45,
                  child: Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: const Text(
                      "click me",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment(buttonAlign, 0),
                  child: Builder(builder: (BuildContext context) {
                    return ElevatedButton(
                      onPressed: () {
                        show(context: context);
                      },
                      child: const Text("AttachedToast"),
                    );
                  }),
                ),
              ),
              ListTile(
                title: Text("buttonAlign: $buttonAlign"),
                trailing: CupertinoSlider(
                  min: -1,
                  max: 1,
                  value: buttonAlign.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      buttonAlign = value;
                    });
                  },
                ),
              ),
              Text(
                "$preferDirection",
                style: const TextStyle(fontSize: 15),
              ),
              Row(
                children: <Widget>[
                  const Expanded(
                    child: SizedBox.shrink(),
                  ),
                  Expanded(
                      child: Radio(
                          value: PreferDirection.topLeft,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                  Expanded(
                      child: Radio(
                          value: PreferDirection.topCenter,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                  Expanded(
                      child: Radio(
                          value: PreferDirection.topRight,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                  const Spacer(),
                ],
              ),
              Row(
                children: const <Widget>[
                  Spacer(),
                  Expanded(
                      child: Text(
                    "topLeft",
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "topCenter",
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "topRight",
                    textAlign: TextAlign.center,
                  )),
                  Spacer(),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Radio(
                          value: PreferDirection.leftTop,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Expanded(
                      child: Radio(
                          value: PreferDirection.rightTop,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                ],
              ),
              Row(
                children: const <Widget>[
                  Expanded(
                      child: Text(
                    "leftTop",
                    textAlign: TextAlign.center,
                  )),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Expanded(
                      child: Text(
                    "rightTop",
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Radio(
                          value: PreferDirection.leftCenter,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Expanded(
                      child: Radio(
                          value: PreferDirection.rightCenter,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                ],
              ),
              Row(
                children: const <Widget>[
                  Expanded(
                      child: Text(
                    "leftCenter",
                    textAlign: TextAlign.center,
                  )),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Expanded(
                      child: Text(
                    "rightCenter",
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Radio(
                          value: PreferDirection.leftBottom,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  Expanded(
                      child: Radio(
                          value: PreferDirection.rightBottom,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                ],
              ),
              Row(
                children: const <Widget>[
                  Expanded(
                      child: Text(
                    "leftBottom",
                    textAlign: TextAlign.center,
                  )),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Expanded(
                      child: Text(
                    "rightBottom",
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
              Row(
                children: <Widget>[
                  const Spacer(),
                  Expanded(
                      child: Radio(
                          value: PreferDirection.bottomLeft,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                  Expanded(
                      child: Radio(
                          value: PreferDirection.bottomCenter,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                  Expanded(
                      child: Radio(
                          value: PreferDirection.bottomRight,
                          groupValue: preferDirection,
                          onChanged: (PreferDirection? value) {
                            setState(() {
                              preferDirection = value!;
                            });
                          })),
                  const Spacer(),
                ],
              ),
              Row(
                children: const <Widget>[
                  Spacer(),
                  Expanded(
                      child: Text(
                    "bottomLeft",
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "bottomCenter",
                    textAlign: TextAlign.center,
                  )),
                  Expanded(
                      child: Text(
                    "bottomRight",
                    textAlign: TextAlign.center,
                  )),
                  Spacer(),
                ],
              ),
              SwitchListTile(
                value: ignoreContentClick,
                onChanged: (bool value) {
                  setState(() {
                    ignoreContentClick = value;
                  });
                },
                title: const Text("ignoreContentClick: "),
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
                value: allowClick,
                onChanged: (bool value) {
                  setState(() {
                    allowClick = value;
                  });
                },
                title: const Text("allowClick: "),
              ),
              SwitchListTile(
                value: enableSafeArea,
                onChanged: (bool value) {
                  setState(() {
                    enableSafeArea = value;
                  });
                },
                title: const Text("enableSafeArea: "),
              ),
              ListTile(
                title: Text("duration:   ${second}s"),
                trailing: CupertinoSlider(
                  min: 1,
                  max: 20,
                  value: second.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      second = value.toInt();
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
              ListTile(
                title: Text("verticalOffset:   ${verticalOffset.toString()}"),
                trailing: CupertinoSlider(
                  min: 0,
                  max: 40,
                  value: verticalOffset.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      verticalOffset = value;
                    });
                  },
                ),
              ),
              ListTile(
                title:
                    Text("horizontalOffset:   ${horizontalOffset.toString()}"),
                trailing: CupertinoSlider(
                  min: 0,
                  max: 40,
                  value: horizontalOffset.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      horizontalOffset = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Expanded(child: Text("backgroundColor:")),
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
