import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _CustomLoadWidget extends StatelessWidget {
  final CancelFunc cancelFunc;

  const _CustomLoadWidget({Key key, this.cancelFunc}) : super(key: key);

  void handleTap(){
    BotToast.showCustomText(
        onlyOne: true,
        duration: null,
        toastBuilder: (textCancel) => Align(
          alignment: Alignment(0, 0.8),
          child: Card(
            child: Row(
              mainAxisSize:
              MainAxisSize.min,
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors
                          .redAccent,
                    ),
                    onPressed: () {
                      cancelFunc();
                      textCancel();
                    }),
                Padding(
                  padding:
                  const EdgeInsets
                      .symmetric(
                      horizontal:
                      8.0),
                  child: Text("me too"),
                )
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                ),
                onPressed: handleTap,
              ),
              Text(
                "i miss you",
              )
            ],
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CustomLoading"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  BotToast.showCustomLoading(
                      clickClose: clickClose,
                      allowClick: allowClick,
                      ignoreContentClick: ignoreContentClick,
                      duration: Duration(
                        seconds: seconds,
                      ),
                      backgroundColor: Color(backgroundColor),
                      loadWidget: (cancelFunc) {
                        return _CustomLoadWidget(cancelFunc: cancelFunc);
                      });
                },
                child: Text("CustomLoading"),
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
                value: clickClose,
                onChanged: (value) {
                  setState(() {
                    clickClose = value;
                  });
                },
                title: Text("clickClose: "),
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
                    Text("backgroundColor:   "),
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
BotToast.showLoading(
         clickClose: clickClose,
         allowClick: allowClick,
         duration: Duration(
           seconds: seconds,
         ),
         backgroundColor: Color(backgroundColor)
);
""";
