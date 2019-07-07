import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class SimpleNotification extends StatefulWidget {
  @override
  _SimpleNotificationState createState() => _SimpleNotificationState();
}

class _SimpleNotificationState extends State<SimpleNotification> {
  bool enableSlideOff = true;
  bool hideCloseButton = false;
  bool onlyOne = false;

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
                      onlyOne: onlyOne
                  );
                },
                child: Text("simpleNotification"),
              ),
              CheckboxListTile(
                value: enableSlideOff,
                onChanged: (value) {
                  setState(() {
                    enableSlideOff = value;
                  });
                },
                title: Text("enableSlideOff: "),
              ),
              CheckboxListTile(
                value: hideCloseButton,
                onChanged: (value) {
                  setState(() {
                    hideCloseButton = value;
                  });
                },
                title: Text("hideCloseButton: "),
              ),
              CheckboxListTile(
                value: onlyOne,
                onChanged: (value) {
                  setState(() {
                    onlyOne = value;
                  });
                },
                title: Text("onlyOne: "),
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
         
         onlyOne: onlyOne
         
);
""";
