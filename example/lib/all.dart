import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bot_toast/bot_toast.dart';

class All extends StatefulWidget {
  @override
  _AllState createState() => _AllState();
}

class _AllState extends State<All> {
  @override
  void initState() {
    BotToast.showLoading(duration: const Duration(seconds: 2));
    BotToast.showSimpleNotification(title: "init");
    BotToast.showText(text: "init");
    BotToast.showAttachedWidget(
        attachedBuilder: (_) => const Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                ),
              ),
            ),
        enableSafeArea: false,
        duration: const Duration(seconds: 2),
        target: const Offset(52, 0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All"),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Divider(),
              const Text("code"),
              const Divider(),
              Text(
                _code,
                textAlign: TextAlign.start,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

String _code = '''
  @override
  void initState() {
    BotToast.showLoading(duration: Duration(seconds: 2));
    BotToast.showSimpleNotification(title: "init");
    BotToast.showText(text: "init");
    BotToast.showAttachedWidget(
        attachedWidget: (_) => Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.favorite,
                  color: Colors.redAccent,
                ),
              ),
            ),
        duration: Duration(seconds: 2),
        target: Offset(520, 520));

    super.initState();
  }
''';
