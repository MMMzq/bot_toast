BotToast 🐷
========= 

## 一个真正意义上的flutter Toast库!

###  🐶特点

- 真正意义上的Toast,可以在任何你需要的时候调用,不会有任何限制！ 

- 支持在弹出各种自定义Toast,或者说你可以弹出任何Widget,只要它符合flutter代码的要求即可

- 使用时不用传入BuildContext,这意味着你可以脱离BuildContext的限制

- BotToast弹出的弹窗可以跨越多个页面存在

- 以flutter的方式实现,不需要任何原生代码,这意味的兼容会得到很好的保证

### 🐺效果图
(全损画质😂)

> **标准使用**

![普通使用](https://raw.githubusercontent.com/MMMzq/bot_toast/master/doc/media/demo1.gif)

> **结合dio使用**

![结合dio](https://github.com/MMMzq/bot_toast/raw/master/doc/media/demo2.gif)

### 🐮快速使用

#### 1. pubspec.yaml文件里添加依赖
```
dependencies:
     bot_toast: 0.0.1
```

#### 2. 导入BotToast库
```
import 'package:bot_toast/bot_toast.dart';
```

#### 3. 添加BotToastInit
```
///像这样,BotToast将会自动去初始化
MaterialApp(
      title: 'BotToast Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BotToastInit(child: EnterPage()),
    );
```


#### 4. 使用BotToast
```
BotToast.showText(text:"xxxx")  //弹出一个文本框;
```

```
fianl cancel=BotToast.showLoading(); //弹出一个加载动画
cancel(); //关闭加载动画
```

```
///弹出一个自定义页面
BotToast.showWidget(
    widget: Center(
        child: Card(
            child: Text("这是个自定义页面"),
            ),
        )
    );
```


