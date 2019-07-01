import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              child: Text("标准 demo"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CommonDemo()));
              },
            ),
            RaisedButton(
              child: Text("Dio demo"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => DioDemo()));
              },
            )
          ],
        ),
      ),
    );
  }
}

//------------------------------dio demo-----------------------------
Dio dio = new Dio();
Dio dioInterceptor = new Dio()
  ..interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
    BotToast.showLoading();
    return options; //continue
  }, onResponse: (Response response) {
    BotToast.closeAllLoading();
    BotToast.showText(text: "请求成功!");
    return response; // continue
  }, onError: (DioError e) {
    BotToast.closeAllLoading();
    BotToast.showText(text: "请求错误!");
    return e; //continue
  }));

class DioDemo extends StatefulWidget {
  @override
  _DioDemoState createState() => _DioDemoState();
}

class _DioDemoState extends State<DioDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dio demo"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                child: Text("使用dio发送请求"),
                onPressed: () async {
                  final cancel = BotToast.showLoading();
                  await dio.get("https://github.com/MMMzq/bot_toast");
                  cancel();
                  BotToast.showText(text: "get成功!");
                },
              ),
              RaisedButton(
                child: Text("加入dio拦截器 自动为请求添加加载动画!"),
                onPressed: () async {
                  await dioInterceptor.get("https://github.com/MMMzq/bot_toast");
                },
              ),
              RaisedButton(
                child: Text("加入dio拦截器 自动为请求添加加载动画!(模拟请求异常的情况)"),
                onPressed: () async {
                  await dioInterceptor.get("https://github.com/MMMzq/bot_toasttttttttt");
                },
              ),
              RaisedButton(
                child: Text("跳进下一个页面,并且在下一个页面的initState里使用dio模拟首次加载!"),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>DioInitDemo()));

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DioInitDemo extends StatefulWidget {
  @override
  _DioInitDemoState createState() => _DioInitDemoState();
}

class _DioInitDemoState extends State<DioInitDemo> {
  List<String> datas=[];
  bool isLoaded = false;


  @override
  void initState() {
    super.initState();
    loadError();
  }

  //模拟首次加载错误的情况
  void loadError()async{
    final cancel = BotToast.showLoading();
    await dio.get("https://github.com/MMMzq/bot_toast");
    try{
      await Future.delayed(Duration(seconds: 3),(){
        throw Exception("加载错误啦!");
      });
    }finally{
      cancel();
      BotToast.showText(text: "加载错误啦!");
      setState(() {
        isLoaded=true;
      });
    }
  }

  //模拟加载成功的情况
  void loadSuccess()async{
    final cancel = BotToast.showLoading();
    await dio.get("https://github.com/MMMzq/bot_toast");
    await Future.delayed(Duration(seconds: 2),(){
      setState(() {
        datas.addAll(["麻辣香锅","水煮鱼","潮汕火锅","螺丝粉"]);
      });
    });
    cancel();
    BotToast.showText(text: "加载成功!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dio initState首次加载"),
        centerTitle: true,
      ),
      body: isLoaded&&datas.isEmpty?Center(
        child: RaisedButton(onPressed: loadSuccess,child: Text("点击我重新加载"),),
      ):Container(
        margin: EdgeInsets.all(20),
        child: ListView(
          children: datas.map((text)=>FlatButton(

            child: ListTile(title: Text(text),), onPressed: () {},
          )).toList(),
        ),
      ),
    );
  }
}


//------------------------------common demo-----------------------------

class CommonDemo extends StatefulWidget {
  CommonDemo({Key key}) : super(key: key);

  @override
  _CommonDemoState createState() => _CommonDemoState();
}

class _CommonDemoState extends State<CommonDemo> {
  CancelFunc cancelFunc;
  CancelFunc loadingCancelFunc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("BotToast标准demo"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text("自定义Toast:显示在中上"),
              onPressed: () {
                UniqueKey key = UniqueKey();
                BotToast.showWidget(
                    widget: GestureDetector(
                      onTap: () {
                        BotToast.remove(key);
                      },
                      child: custom((Alignment.topCenter)),
                    ),
                    key: key);
              },
            ),
            FlatButton(
              child: Text("自定义Toast:显示在中间"),
              onPressed: () {
                UniqueKey key = UniqueKey();
                BotToast.showWidget(
                    widget: GestureDetector(
                      onTap: () {
                        BotToast.remove(key);
                      },
                      child: custom((Alignment.center)),
                    ),
                    key: key);
              },
            ),
            FlatButton(
              child: Text("自定义Toast:显示在中下"),
              onPressed: () {
                UniqueKey key = UniqueKey();
                BotToast.showWidget(
                    widget: GestureDetector(
                      onTap: () {
                        BotToast.remove(key);
                      },
                      child: custom((Alignment.bottomCenter)),
                    ),
                    key: key);
              },
            ),
            FlatButton(
              child: Text("Text:显示"),
              onPressed: () {
                cancelFunc = BotToast.showText(
                    text:
                    "Column is also layout widget. It takes a list of children andThis method is rerun every time setState is called, for instance as done");
              },
            ),
            FlatButton(
              child: Text("Text:显示(允许点击屏幕关闭)"),
              onPressed: () {
                cancelFunc = BotToast.showText(
                  clickClose: true,
                    text:
                    "Column is also layout widget. It takes a list of children andThis method is rerun every time setState is called, for instance as done");
              },
            ),
            FlatButton(
              child: Text("Text:提前关闭"),
              onPressed: () {
                cancelFunc();
              },
            ),
            FlatButton(
              child: Text("Text:提前关闭全部"),
              onPressed: () {
                BotToast.removeAll(BotToast.textKey);
              },
            ),
            FlatButton(
              child: Text("Loading:显示默认"),
              onPressed: () {
                loadingCancelFunc = BotToast.showLoading();
                Future.delayed(Duration(seconds: 2), loadingCancelFunc);
              },
            ),
            FlatButton(
              child: Text("Loading:显示 allowClick: true"),
              onPressed: () {
                loadingCancelFunc = BotToast.showLoading(allowClick: true);
              },
            ),
            FlatButton(
              child: Text("Loading:显示 clickClose: true"),
              onPressed: () {
                loadingCancelFunc = BotToast.showLoading(clickClose: true);
              },
            ),
            FlatButton(
              child: Text("Loading:提前关闭当前Loading"),
              onPressed: () {
                loadingCancelFunc();
              },
            ),
            FlatButton(
              child: Text("Loading:提前关闭全部"),
              onPressed: () {
                BotToast.closeAllLoading();
              },
            ),
            FlatButton(
              child: Text("跨页面显示"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>Scaffold(
                  appBar: AppBar(title: Text("跨页面显示"),centerTitle: true,),
                  body: Center(
                    child: RaisedButton(
                      child: Text("Loading:显示 allowClick: true"),
                      onPressed: () {
                        loadingCancelFunc = BotToast.showLoading(allowClick: true);
                      },
                    ),
                  ),
                )));
              },
            ),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget custom(Alignment alignment) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 78),
      child: Align(
        alignment: alignment,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text("这是个自定义的页面"),
          ),
        ),
      ),
    )),
  );
}
