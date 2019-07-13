import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextSample extends StatefulWidget {
  @override
  _TextSampleState createState() => _TextSampleState();
}

class _TextSampleState extends State<TextSample> {
  int seconds = 2;
  bool clickClose = false;
  bool onlyOne = true;
  bool crossPage=true;

  double align = 0.8;
  int fontSize = 17;
  int borderRadius = 8;
  int fontColor = 0xFFFFFFFF;
  int backgroundColor = 0x00000000;
  int contentColor = 0x8A000000;

  int index=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TextToast"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  BotToast.showText(
                      text: (index++).isOdd?"Always together☺":"My mind is all about you.😘",
                      duration: Duration(seconds: seconds),
                      onlyOne: onlyOne,
                      clickClose: clickClose,
                      crossPage: crossPage,
                      align: Alignment(0, align),
                      textStyle: TextStyle(
                          color: Color(fontColor),
                          fontSize: fontSize.toDouble()),
                      borderRadius:
                          BorderRadius.circular(borderRadius.toDouble()),
                      backgroundColor: Color(backgroundColor),
                      contentColor: Color(contentColor));
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
              ListTile(
                title: Text("align:  Alignment(0, $align)"),
                trailing: CupertinoSlider(
                  min: -1,
                  max: 1,
                  value: align,
                  onChanged: (double value) {
                    setState(() {
                      align = double.parse(value.toStringAsFixed(2));
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("borderRadius:  $borderRadius"),
                trailing: CupertinoSlider(
                  min: 1,
                  max: 20,
                  value: borderRadius.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      borderRadius = value.toInt();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text("fontSize:  $fontSize"),
                trailing: CupertinoSlider(
                  min: 10,
                  max: 30,
                  value: fontSize.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      fontSize = value.toInt();
                    });
                  },
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("fontColor:   "),
                    Container(
                      height: 20,
                      width: 20,
                      color: Color(fontColor),
                    )
                  ],
                ),
                trailing: CupertinoSlider(
                  min: 0x00000000,
                  max: 0xffffffff,
                  value: fontColor.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      fontColor = value.toInt();
                    });
                  },
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("background:",overflow: TextOverflow.fade,),
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
              ListTile(
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("contentColor:   "),
                    Container(
                      height: 20,
                      width: 20,
                      color: Color(contentColor),
                    )
                  ],
                ),
                trailing: CupertinoSlider(
                  min: 0x00000000,
                  max: 0xffffffff,
                  value: contentColor.toDouble(),
                  onChanged: (double value) {
                    setState(() {
                      contentColor = value.toInt();
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
BotToast.showText(
    text: (index++).isOdd?"Always together☺":"My mind is all about you.😘",
    duration: Duration(seconds: seconds),
    onlyOne: onlyOne,
    clickClose: clickClose,
    crossPage: crossPage,
    align: Alignment(0, align),
    textStyle: TextStyle(
        color: Color(fontColor),
        fontSize: fontSize.toDouble()),
    borderRadius:
        BorderRadius.circular(borderRadius.toDouble()),
    backgroundColor: Color(backgroundColor),
    contentColor: Color(contentColor));
""";
