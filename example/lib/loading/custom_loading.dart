import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _CustomLoadWidget extends StatefulWidget {
  final CancelFunc cancelFunc;

  const _CustomLoadWidget({Key? key,required this.cancelFunc}) : super(key: key);

  @override
  __CustomLoadWidgetState createState() => __CustomLoadWidgetState();
}

class __CustomLoadWidgetState extends State<_CustomLoadWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    animationController.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animationController.forward();
      }
    });
    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void handleTap() {
    BotToast.showCustomText(
        onlyOne: true,
        duration: null,
        toastBuilder: (textCancel) => Align(
              alignment: const Alignment(0, 0.8),
              child: Card(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          widget.cancelFunc();
                          textCancel();
                        }),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("Tap loading toast"),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FadeTransition(
              opacity: animationController,
              child: IconButton(
                icon: const Icon(Icons.favorite, color: Colors.redAccent, size: 30),
                onPressed: handleTap,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Loading",
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomLoading extends StatefulWidget {
  @override
  _CustomLoadingState createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> {
  int backgroundColor = 0x42000000;
  int seconds = 10;
  bool clickClose = true;
  bool allowClick = true;
  bool ignoreContentClick = false;
  bool crossPage = true;
  int animationMilliseconds = 200;
  int animationReverseMilliseconds = 200;
  BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CustomLoading"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  BotToast.showCustomLoading(
                      clickClose: clickClose,
                      allowClick: allowClick,
                      backButtonBehavior: backButtonBehavior,
                      ignoreContentClick: ignoreContentClick,
                      animationDuration:
                          Duration(milliseconds: animationMilliseconds),
                      animationReverseDuration:
                          Duration(milliseconds: animationReverseMilliseconds),
                      duration: Duration(
                        seconds: seconds,
                      ),
                      backgroundColor: Color(backgroundColor),
                      align: Alignment.center,
                      toastBuilder: (cancelFunc) {
                        return _CustomLoadWidget(cancelFunc: cancelFunc);
                      });
                },
                child: const Text("CustomLoading"),
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

              const Center(child: Text('BackButtonBehavior'),),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(value: BackButtonBehavior.none,
                      groupValue: backButtonBehavior,
                      onChanged: (BackButtonBehavior? value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('none'),),
                  ),
                  Expanded(
                    child: RadioListTile(value: BackButtonBehavior.ignore,
                      groupValue: backButtonBehavior,
                      onChanged: (BackButtonBehavior? value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('ignore'),),
                  ),
                  Expanded(
                    child: RadioListTile(value: BackButtonBehavior.close,
                      groupValue: backButtonBehavior,
                      onChanged: (BackButtonBehavior? value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('close'),),
                  )
                ],
              ),
              SwitchListTile(
                value: clickClose,
                onChanged: (bool value) {
                  setState(() {
                    clickClose = value;
                  });
                },
                title: const Text("clickClose: "),
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
                value: ignoreContentClick,
                onChanged: (bool value) {
                  setState(() {
                    ignoreContentClick = value;
                  });
                },
                title: const Text("ignoreContentClick: "),
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
