import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'all.dart';
import 'attached_toast/attached_toast.dart';
import 'custom/custom_animation.dart';
import 'custom/custom_widget.dart';
import 'loading/custom_loading.dart';
import 'loading/loading.dart';
import 'notification/custom_notification.dart';
import 'notification/simple_notification.dart';
import 'notification/notification.dart' as notification;
import 'text/custom_text.dart';
import 'text/text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      title: 'BotToast Demo',
      navigatorObservers: [BotToastNavigatorObserver()],
      home: EnterPage(),
    );
  }
}

class EnterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BotToast"),
          centerTitle: true,
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Column(children: <Widget>[
                Text(
                  "Notification",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SimpleNotification()));
                          },
                          child: Text("SimpleNotification"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        notification.Notification()));
                          },
                          child: Text("Notification"),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CustomNotification()));
                    },
                    child: Text("CustomNotification"),
                  ),
                ),
                Container(
                  height: 40,
                ),
                Text(
                  "TextToast",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TextSample()));
                          },
                          child: Text("TextToast"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CustomText()));
                          },
                          child: Text("CustomText"),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 40,
                ),
                Text(
                  "Load",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => Loading()));
                          },
                          child: Text("Loading"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CustomLoading()));
                          },
                          child: Text("CustomLoading"),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Other',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AttachedToast()));
                          },
                          child: Text('AttachedToast'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => All()));
                          },
                          child: Text("All"),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CustomAnimation()));
                          },
                          child: const Text('CustomAnimation'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CustomWidget()));
                          },
                          child: const Text('CustomWidget'),
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
        ));
  }
}
