import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Notification extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  bool enableSlideOff = true;
  bool hideCloseButton = false;
  bool onlyOne = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  BotToast.showNotification(
                      leading: (_) => SizedBox.fromSize(
                          size: const Size(40, 40),
                          child: ClipOval(
                              child: Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ))),
                      title: (_) => Text('I love u'),
                      subtitle: (_) => Text("let's be together"),
                      trailing: (cancel) => IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: cancel,
                          ),
                      enableSlideOff: enableSlideOff,
                      hideCloseButton: hideCloseButton,
                      onlyOne: onlyOne,
                  );
                },
                child: Text("notification"),
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
String _code=
"""
BotToast.showNotification(
         leading: (_) => SizedBox.fromSize(
                          size: const Size(40, 40),
                          child: ClipOval(
                              child: Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ))),
                          
         title: (_) => Text('I love u'),
         
         subtitle: (_) => Text("let's be together"),
         
         trailing: (cancel) => IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: cancel,),
                          
         enableSlideOff: enableSlideOff,
         
         hideCloseButton: hideCloseButton,
         
         onlyOne: onlyOne,
);
""";
