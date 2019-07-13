import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bot_toast/bot_toast.dart';

class AttachedToast extends StatefulWidget {
  @override
  _AttachedToastState createState() => _AttachedToastState();
}

class _AttachedToastState extends State<AttachedToast> {
  BuildContext targetContext;
  Offset target;
  double verticalOffset = 24;
  int second = 4;
  PreferDirection preferDirection = PreferDirection.Below;
  bool ignoreContentClick = false;
  bool onlyOne = true;
  bool crossPage = false;
  bool allowClick = true;
  int backgroundColor = 0x00000000;

  double buttonAlign=0;

  CancelFunc show({BuildContext context, Offset target}) {
    return BotToast.showAttachedWidget(
        target: target,
        targetContext: context,
        verticalOffset: verticalOffset,
        duration: Duration(seconds: second),
        preferDirection: preferDirection,
        ignoreContentClick: ignoreContentClick,
        onlyOne: onlyOne,
        crossPage: crossPage,
        allowClick: allowClick,
        backgroundColor: Color(backgroundColor),
        attachedWidget: (cancel) => (Card(
              child: IconButton(
                padding: EdgeInsets.all(20),
                onPressed: (){
                  BotToast.showSimpleNotification(title: "Let's go travel together.😘");
                },
                icon: Icon(Icons.favorite,color: Colors.redAccent,),
              ),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AttachedToast"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTapDown: (details) {
                  setState(() {
                    verticalOffset=0;

                  });
                  show(target: details.globalPosition);
                },
                child: Container(
                  color: Colors.redAccent,
                  height: 100,
                  width: 300,
                  alignment: Alignment.center,
                  child: Text(
                    "click me",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Align(
                  alignment: Alignment(buttonAlign, 0),
                  child: Builder(builder: (context) {
                    return RaisedButton(
                      onPressed: () {
                        show(context: context);
                      },
                      child: Text("AttachedToast"),
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
              SwitchListTile(
                value: preferDirection == PreferDirection.Below,
                onChanged: (value) {
                  setState(() {
                    preferDirection =
                        value ? PreferDirection.Below : PreferDirection.Upside;
                  });
                },
                title: Text("preferDirection: $preferDirection"),
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
              SwitchListTile(
                value: allowClick,
                onChanged: (value) {
                  setState(() {
                    allowClick = value;
                  });
                },
                title: Text("allowClick: "),
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
BotToast.showAttachedWidget(
        target: target,
        targetContext: context,
        verticalOffset: verticalOffset,
        duration: Duration(seconds: second),
        preferDirection: preferDirection,
        ignoreContentClick: ignoreContentClick,
        onlyOne: onlyOne,
        crossPage: crossPage,
        allowClick: allowClick,
        backgroundColor: Color(backgroundColor),
        attachedWidget: (cancel) => (Card(
              child: IconButton(
                padding: EdgeInsets.all(20),
                onPressed: (){
                  BotToast.showSimpleNotification(title: "Let's go travel together.😘");
                },
                icon: Icon(Icons.favorite,color: Colors.redAccent,),
              ),
)));
""";
