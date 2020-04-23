BotToast 🤖
========= 
一个真正意义上的flutter Toast库!

[![](https://img.shields.io/pub/v/bot_toast.svg?label=bot_toast&logo=https%3A%2F%2Fpub.flutter-io.cn%2Fpackages%2Fbot_toast)](https://pub.flutter-io.cn/packages/bot_toast)
[![Build Status](https://github.com/MMMzq/bot_toast/workflows/CI/badge.svg)](https://github.com/MMMzq/bot_toast/actions)
[![codecov](https://codecov.io/gh/MMMzq/bot_toast/branch/master/graph/badge.svg)](https://codecov.io/gh/MMMzq/bot_toast)

### Language: [English](README.md) | 中文简体

* [🐲概述](#概述)
* [🐼在线Demo](#在线demo)
* [🐳示例项目](#示例项目)
* [🐺效果图](#效果图)
* [🐮快速使用](#快速使用) 
* [🐼2.0版本](#20版本)
* [🐨注意事项](#注意事项) 
* [📃主要Api文档](#主要Api文档) 

<br>

###  🐲概述

- 真正意义上的Toast,可以在任何你需要的时候调用,不会有任何限制! (这是他最重要的特点,跟别的Toast库不同的地方)

- 功能丰富,支持显示通知,文本,加载,附属等类型Toast

- 支持在弹出各种自定义Toast,或者说你可以弹出任何Widget,只要它符合flutter代码的要求即可

- Api简单易用,基本上没有必要参数(包括BuildContext),基本上都是可选参数

- 纯flutter实现,不容易带来兼容问题



### 🐼在线demo

**[在线例子](https://mmmzq.github.io/bot_toast/#/)** (Web效果可能有偏差,真实效果请以手机端为准,第一次加载可能会很久)

### 🐳示例项目
**[sample project](example)**

### 🐺效果图

Notification|Attached|CustomAnimation
--------|-------|--------
![Notification](doc/gif/notification.gif)|![Attached](doc/gif/attached.gif)|![CustomAnimation](doc/gif/custom_animation.gif)

Loading|Text|CustomWidget
--------|-------|----------
![Loading](doc/gif/loading.gif)|![Text](doc/gif/text.gif)|![CustomWidget](doc/gif/custom_widget.gif)

### 🐮快速使用

#### 1. pubspec.yaml文件里添加依赖
``` dart
dependencies:
     bot_toast: ^2.4.1
```

#### 2. 导入BotToast库
``` dart
import 'package:bot_toast/bot_toast.dart';
```

#### 3. 初始化BotToast

``` dart
//1.使用BotToastInit直接包裹MaterialApp
BotToastInit(
  child:MaterialApp(
      title: 'BotToast Demo',
      navigatorObservers: [BotToastNavigatorObserver()],//2.注册路由观察者
      home: XxxxPage(),
  )
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

### 🐼2.0版本

#### 主要改动:

- 支持自定义Toast的**动画**和持续时间😉

- 添加`showAnimationWidget`方法,可以使用此方法来高度自定义一个有动画的Toast🤩

- 修改了初始化的方式使之更为通用,1.x版本升级到2.0修改需手动修改来进行适配。(参考了[overlay_support](https://github.com/boyan01/overlay_support)库的初始化方式,非常感谢)

- 删除`reInit`方法(2.0版本不再需要),以及`PreferDirection.Below`和`PreferDirection.Upside`这两个已经被弃用的枚举

- [更详细的2.0版本改动,点击查看](CHANGELOG.md#200)

####  1.x版本升级到2.x版本

- 修改BotInit使用的位置,现在是直接包裹`MaterialApp`,而不是`XxxPage`

``` dart
///1.x.x版本的初始化方式
MaterialApp(
      title: 'BotToast Demo',
      navigatorObservers: [BotToastNavigatorObserver()],
      home: BotToastInit(  //2.初始化BotToast
          child: XxxxPage()
      ),
    );
```
改为:
``` dart
//2.x.x版本的初始化方式
//使用BotToastInit直接包裹MaterialApp
BotToastInit(
  child:MaterialApp(
      title: 'BotToast Demo',
      navigatorObservers: [BotToastNavigatorObserver()],
      home: XxxxPage(),
  )
);
```

- 修改`showEnhancedWidget`的`warpWidget`参数的方法入参(注意这一步不一定需要,这取决于你是否使用过`showEnhancedWidget`,如果没有使用过,这步可以省略)
```dart
///1.x.x版本
showEnhancedWidget(
  ...
  warpWidget:(widget)=>XxxWrap(child:widget);
  ...
)
```
改为:
```dart
///2.x.x版本
showEnhancedWidget(
  ...
  warpWidget:(cancel,widget)=>XxxWrap(child:widget);
  ...
)
```

<br>


### 🐨注意事项

- 如果你项目有多个[Navigator],请将该BotToastNavigatorObserver添加到[Navigator.observers]

- [ToastBuilder]方法生成widget时,请确保生成的Widget背景不会吸收点击事件,例如[Scaffold],[Material]都会默认占满整个父空间,
并且会吸收事件(就算透明也是这种情况),具体例子可看[material.dart->_RenderInkFeatures class->hitTestSelf method] 如果真的要生成,可以考虑使用[IgnorePointer],如果没有遵守规则,将会时某些功能失效例如[allowClick]功能就会失效




#### 更详细的实现细节请看[bot_toast是怎样炼成的](https://juejin.im/post/5d2b0261f265da1bb003edc6)

<br>

###  📃主要Api文档
[主要Api文档](API.md)



