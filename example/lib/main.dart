import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'all.dart';
import 'attached_toast/attached_toast.dart';
import 'custom/custom_animation.dart';
import 'custom/custom_widget.dart';
import 'loading/custom_loading.dart';
import 'loading/loading.dart';
import 'notification/custom_notification.dart';
import 'notification/notification.dart' as notification;
import 'notification/simple_notification.dart';
import 'text/custom_text.dart';
import 'text/text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.black, backgroundColor: Colors.grey[300],
        ),
      )),
      builder: (_, Widget? child) {
        return BotToastBuilder(child: child!);
      },
      title: 'BotToast Demo',
      navigatorObservers: <NavigatorObserver>[BotToastNavigatorObserver()],
      home: const EnterPage(),
    );
  }
}

class EnterPage extends StatelessWidget {
  const EnterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BotToast'),
          centerTitle: true,
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              child: Column(children: <Widget>[
                const Text(
                  'Notification',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SimpleNotification()));
                          },
                          child: const Text('SimpleNotification'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        const notification.Notification()));
                          },
                          child: const Text('Notification'),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CustomNotification()));
                    },
                    child: const Text('CustomNotification'),
                  ),
                ),
                Container(
                  height: 40,
                ),
                const Text(
                  'TextToast',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const TextSample()));
                          },
                          child: const Text('TextToast'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CustomText()));
                          },
                          child: const Text('CustomText'),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 40,
                ),
                const Text(
                  'Load',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const Loading()));
                          },
                          child: const Text('Loading'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CustomLoading()));
                          },
                          child: const Text('CustomLoading'),
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Other',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                const Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const AttachedToast()));
                          },
                          child: const Text('AttachedToast'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => const All()));
                          },
                          child: const Text('All'),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CustomAnimation()));
                          },
                          child: const Text('CustomAnimation'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const CustomWidget()));
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
