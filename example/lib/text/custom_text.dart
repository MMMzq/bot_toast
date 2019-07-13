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
                                          closeIcon: Icon(Icons.favorite,color: Colors.redAccent,),
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
BotToast.showCustomText(
  duration: Duration(seconds: seconds),
  onlyOne: onlyOne,
  clickClose: clickClose,
  crossPage: crossPage,
  ignoreContentClick: ignoreContentClick,
  backgroundColor: Color(backgroundColor),
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
                        closeIcon: Icon(Icons.favorite,color: Colors.redAccent,),
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
""";
