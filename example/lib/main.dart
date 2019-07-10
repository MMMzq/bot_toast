import 'package:bot_toast/bot_toast.dart';
import 'package:example/text/text.dart';
import 'package:flutter/material.dart';

import 'notification/custom_notification.dart';
import 'notification/simple_notification.dart';
import 'notification/notification.dart' as notification;
import 'text/custom_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BotToast Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BotToastInit(child: EnterPage()),
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
            child: Column(
              children: <Widget>[
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
                TextField(),
                LayoutBuilder(builder: (context, constraints) {
                  print(constraints);
                  print(MediaQuery.of(context).viewInsets.bottom);
                  print(MediaQuery.of(context).padding.bottom);
                  return RaisedButton(
                    child: Text("Test"),
                    onPressed: () {

                    },
                  );
                }),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

////------------------------------common demo-----------------------------
//
//class CommonDemo extends StatefulWidget {
//  CommonDemo({Key key}) : super(key: key);
//
//  @override
//  _CommonDemoState createState() => _CommonDemoState();
//}
//
//class _CommonDemoState extends State<CommonDemo> {
//  CancelFunc cancelFunc;
//  CancelFunc loadingCancelFunc;
//
//  @override
//  void initState() {
//    BotToast.showNotification(
//        leading: (_) => SizedBox.fromSize(
//            size: const Size(40, 40),
//            child: ClipOval(
//                child: Icon(
//              Icons.favorite,
//              color: Colors.redAccent,
//            ))),
//        title: (_) => Text('I love u'),
////        enableSlideOff: false,
//        subtitle: (_) => Text("let's be together"),
//        trailing: (cancel) => IconButton(
//              icon: Icon(Icons.cancel),
//              onPressed: cancel,
//            ));
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: Colors.blueGrey,
//      appBar: AppBar(
//        title: Text("BotToast标准demo"),
//        centerTitle: true,
//      ),
//      body: Center(
//        child: ListView(
////          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            FlatButton(
//              child: Text("自定义Toast:显示在中上"),
//              onPressed: () {
//                BotToast.showWidget(
//                    toastBuilder: (cancelFunc) => GestureDetector(
//                          onTap: () {
//                            cancelFunc();
//                          },
//                          child: custom((Alignment.topCenter)),
//                        ));
//              },
//            ),
//            FlatButton(
//              child: Text("自定义Toast:显示在中间"),
//              onPressed: () {
//                BotToast.showWidget(
//                    toastBuilder: (cancelFunc) => GestureDetector(
//                          onTap: () {
//                            cancelFunc();
//                          },
//                          child: custom((Alignment.center)),
//                        ));
//              },
//            ),
//            FlatButton(
//              child: Text("自定义Toast:显示在中下"),
//              onPressed: () {
//                BotToast.showWidget(
//                    toastBuilder: (cancelFunc) => GestureDetector(
//                          onTap: () {
//                            cancelFunc();
//                          },
//                          child: custom((Alignment.bottomCenter)),
//                        ));
//              },
//            ),
//            FlatButton(
//              child: Text("Notification:显示"),
//              onPressed: () {
//                cancelFunc = BotToast.showSimpleNotification(
////                  onlyOne: true,
//                    title: "Column is also layout widget",
//                    subTitle: "this is a subTitle");
//              },
//            ),
//            FlatButton(
//              child: Text("Text:显示"),
//              onPressed: () {
//                cancelFunc = BotToast.showText(
//                    text:
//                        "Column is also layout widget. It takes a list of children andThis method is rerun every time setState is called, for instance as done");
//              },
//            ),
//            FlatButton(
//              child: Text("Text:显示(允许点击屏幕关闭)"),
//              onPressed: () {
//                cancelFunc = BotToast.showText(
//                    clickClose: true,
//                    text:
//                        "Column is also layout widget. It takes a list of children andThis method is rerun every time setState is called, for instance as done");
//              },
//            ),
//            FlatButton(
//              child: Text("Text:提前关闭"),
//              onPressed: () {
//                cancelFunc?.call();
//              },
//            ),
//            FlatButton(
//              child: Text("Text:提前关闭全部"),
//              onPressed: () {
//                BotToast.removeAll(BotToast.textKey);
//              },
//            ),
//            FlatButton(
//              child: Text("Loading:显示默认"),
//              onPressed: () {
//                loadingCancelFunc = BotToast.showLoading();
//                Future.delayed(Duration(seconds: 2), loadingCancelFunc);
//              },
//            ),
//            FlatButton(
//              child: Text("Loading:显示 allowClick: true"),
//              onPressed: () {
//                loadingCancelFunc = BotToast.showLoading(allowClick: true);
//              },
//            ),
//            FlatButton(
//              child: Text("Loading:显示 clickClose: true"),
//              onPressed: () {
//                loadingCancelFunc = BotToast.showLoading(clickClose: true);
//              },
//            ),
//            FlatButton(
//              child: Text("Loading:提前关闭当前Loading"),
//              onPressed: () {
//                loadingCancelFunc();
//              },
//            ),
//            FlatButton(
//              child: Text("Loading:提前关闭全部"),
//              onPressed: () {
//                BotToast.closeAllLoading();
//              },
//            ),
//            FlatButton(
//              child: Text("cleanAll:提前关闭全部"),
//              onPressed: () {
//                BotToast.cleanAll();
//              },
//            ),
//            FlatButton(
//              child: Text("跨页面显示"),
//              onPressed: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        builder: (_) => Scaffold(
//                              appBar: AppBar(
//                                title: Text("跨页面显示"),
//                                centerTitle: true,
//                              ),
//                              body: Center(
//                                child: RaisedButton(
//                                  child: Text("Loading:显示 allowClick: true"),
//                                  onPressed: () {
//                                    loadingCancelFunc =
//                                        BotToast.showLoading(allowClick: true);
//                                  },
//                                ),
//                              ),
//                            )));
//              },
//            ),
//          ],
//        ),
//      ),
//      // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
//
//Widget custom(Alignment alignment) {
//  return Scaffold(
//    backgroundColor: Colors.transparent,
//    body: SafeArea(
//        child: Padding(
//      padding: EdgeInsets.symmetric(vertical: 78),
//      child: Align(
//        alignment: alignment,
//        child: Card(
//          child: Padding(
//            padding: EdgeInsets.all(20),
//            child: Text("这是个自定义的页面"),
//          ),
//        ),
//      ),
//    )),
//  );
//}
