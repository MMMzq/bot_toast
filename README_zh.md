BotToast ❤
========= 
一个真正意义上的flutter Toast库!

[![](https://img.shields.io/pub/v/bot_toast.svg?label=bot_toast&logo=https%3A%2F%2Fpub.flutter-io.cn%2Fpackages%2Fbot_toast)](https://pub.flutter-io.cn/packages/bot_toast)
[![Build Status](https://travis-ci.com/MMMzq/bot_toast.svg?branch=master)](https://travis-ci.com/MMMzq/bot_toast)
[![codecov](https://codecov.io/gh/MMMzq/bot_toast/branch/master/graph/badge.svg)](https://codecov.io/gh/MMMzq/bot_toast)

### Language: [English](https://github.com/MMMzq/bot_toast) | 中文简体

* [🐲概述](#概述)
* [🐼在线Demo](#在线demo)
* [🐳示例项目](#示例项目)
* [🐺效果图](#效果图)
* [🐮快速使用](#快速使用) 
* [🐨注意事项](#注意事项) 
* [📃主要Api文档](#主要Api文档) 

###  🐲概述

- 真正意义上的Toast,可以在任何你需要的时候调用,不会有任何限制! (这是他最重要的特点,跟别的Toast库不同的地方)

- 功能丰富,支持显示通知,文本,加载,附属等类型Toast

- 支持在弹出各种自定义Toast,或者说你可以弹出任何Widget,只要它符合flutter代码的要求即可

- Api简单易用,基本上没有必要参数(包括BuildContext),基本上都是可选参数

- 纯flutter实现,不容易带来兼容问题

### 🐼在线demo

**[在线例子](https://mmmzq.github.io/bot_toast/#/)** (Web效果可能有偏差,真实效果请以手机端为准)

### 🐳示例项目
**[sample project](https://github.com/MMMzq/bot_toast/tree/master/example)**

### 🐺效果图

Notification|Attached
--------|-------
![Notification](https://github.com/MMMzq/bot_toast/raw/master/doc/gif/notification.gif)|![Attached](https://github.com/MMMzq/bot_toast/raw/master/doc/gif/attached.gif)

Loading|Text 
--------|-------
![Loading](https://github.com/MMMzq/bot_toast/raw/master/doc/gif/loading.gif)|![Text](https://github.com/MMMzq/bot_toast/raw/master/doc/gif/text.gif)

### 🐮快速使用

#### 1. pubspec.yaml文件里添加依赖
``` dart
dependencies:
     bot_toast: ^1.1.1
```

#### 2. 导入BotToast库
``` dart
import 'package:bot_toast/bot_toast.dart';
```

#### 3. 初始化BotToast
``` dart
///像这样,BotToast将会自动去初始化
MaterialApp(
      title: 'BotToast Demo',
      navigatorObservers: [BotToastNavigatorObserver()],//1.注册路由观察者
      home: BotToastInit(  //2.初始化BotToast
          child: XxxxPage()
      ),
    );
```


#### 4. 使用BotToast
``` dart
BotToast.showText(text:"xxxx");  //弹出一个文本框;
```

```dart
BotToast.showSimpleNotification(title: "init"); //弹出简单通知Toast
```

```dart
BotToast.showLoading(); //弹出一个加载动画
```

```dart
//弹出一个定位Toast
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
```

<br>

### 🐨注意事项

- 如果你项目有多个[Navigator],请将该BotToastNavigatorObserver添加到[Navigator.observers]

- [ToastBuilder]方法生成widget时,请确保生成的Widget背景不会吸收点击事件,例如[Scaffold],[Material]都会默认占满整个父空间,
并且会吸收事件(就算透明也是这种情况),具体例子可看[material.dart->_RenderInkFeatures class->hitTestSelf method] 如果真的要生成,可以考虑使用[IgnorePointer],如果没有遵守规则,将会时某些功能失效例如[allowClick]功能就会失效

- 如果你在项目中使用了[MaterialApp.navigatorKey]参数请在改变[MaterialApp.navigatorKey]时请调用reInit重新初始化
```
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), //模拟点击改变GlobalKey<NavigatorState>
        (){
          setState(() {
            navigatorState=GlobalKey<NavigatorState>();
            BotToast.reInit(()=>navigatorState.currentState);
          });
        }
    );
    super.initState();
  }
```

#### 更详细的实现细节请看[bot_toast是怎样炼成的](https://juejin.im/post/5d2b0261f265da1bb003edc6)

<br>

### 🐧1.1.0版本说明
- 主要对showAttachedWidget方法进行了增强,现在支持更多方向,定位更准确了。

- `PreferDirection.Below`和`PreferDirection.Upside`被废弃了,可以改用表达更清晰的topCenter,和bottomCenter来代替,且效果完全一致。这两个枚举将会在下个大版本被删除!

- `showAttachedWidget`的`preferDirection` 只是期望的方向,实际的位置可能因为空间不足而遭到调整

- 实际调整顺序可以拿`topLeft`来进行说明,如果上方空间不足则调整为`bottomLeft`,然后左边空间不足的话就再判断右边的空间是否充足,充足的话结果为`bottomRight`,不充足最终结果为`bottomCenter`

<br>

###  📃主要Api文档
[主要Api文档](https://github.com/MMMzq/bot_toast/blob/master/API.md)



