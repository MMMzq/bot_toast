BotToast 🤖
========= 
A really easy to use flutter toast library!

[![](https://img.shields.io/pub/v/bot_toast.svg?label=bot_toast&logo=https%3A%2F%2Fpub.flutter-io.cn%2Fpackages%2Fbot_toast)](https://pub.dev/packages/bot_toast)
[![Build Status](https://github.com/MMMzq/bot_toast/workflows/CI/badge.svg)](https://github.com/MMMzq/bot_toast/actions)
[![codecov](https://codecov.io/gh/MMMzq/bot_toast/branch/master/graph/badge.svg)](https://codecov.io/gh/MMMzq/bot_toast)

### Language: English | [中文简体](README_zh.md)

* [🐲Overview](#Overview)
* [🐼Online Demo](#Online-Demo)
* [🐳Example](#Example)
* [🐺Renderings](#Renderings)
* [🐮Getting started](#Getting-started) 
* [🐼2.0 version](#20-version)
* [📃Documentation](#Documentation) 

###  🐲Overview

- In the true sense of Toast, you can call it whenever you need it, without any restrictions! (This is his most important feature, different from other Toast libraries)

- Feature-rich, support for displaying notifications, text, loading, attachments, etc. Toast

- Support for popping up various custom Toasts, or you can pop up any Widget as long as it meets the requirements of the flutter code.

- Api is easy to use, basically has no necessary parameters (including BuildContext), basically all optional parameters

- Pure flutter implementation, it is not easy to bring compatibility problems


### 🐼Online Demo

**[Online demo](https://mmmzq.github.io/bot_toast/#/)** (Web effects may be biased, the actual effect is subject to the mobile phone)

### 🐳Example
**[Sample project](example)**

### 🐺Renderings

Notification|Attached|CustomAnimation
--------|-------|--------
![Notification](doc/gif/notification.gif)|![Attached](doc/gif/attached.gif)|![CustomAnimation](doc/gif/custom_animation.gif)

Loading|Text|CustomWidget
--------|-------|----------
![Loading](doc/gif/loading.gif)|![Text](doc/gif/text.gif)|![CustomWidget](doc/gif/custom_widget.gif)

### 🐮Getting started

#### 1. add dependencies into you project pubspec.yaml file
``` dart
dependencies:
     bot_toast: ^2.4.1
```

#### 2. import BotToast lib
``` dart
import 'package:bot_toast/bot_toast.dart';
```

#### 3. initialization BotToast
``` dart
//1. wrap MaterialApp with BotToastInit
BotToastInit(
  child:MaterialApp(
      title: 'BotToast Demo',
      navigatorObservers: [BotToastNavigatorObserver()],//2.registered route observer
      home: XxxxPage(),
  )
);
```

#### 4. use BotToast
``` dart
BotToast.showText(text:"xxxx");  //popup a text toast;
```

```dart
BotToast.showSimpleNotification(title: "init"); // popup a sample notification toast;
```

```dart
BotToast.showLoading(); //popup a sample loading toast
```

```dart
//popup a attachments toast
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

### 🐼2.0 version

#### Major changes:

- Support for custom Toast **animation** and **animation duration**

- Add the `showAnimationWidget` method, which can be used to highly customize an animated Toast🤩

- Modified the initialization method to make it more versatile. 1.x version upgrade to 2.0 modification needs manual modification to adapt

- Remove the `reInit` method and the two deprecated enumerations `PreferDirection.Below` and `PreferDirection.Upside`

- [More detailed version 2.0 changes, click to view](CHANGELOG.md#200)

#### 1.x version upgrade to 2.x version

- Modify the location used by BotInit, Now wrap your MaterialApp with `BotToastInit` instead of `XxxPage`

change:
``` dart
///1.x.x version initialization method
MaterialApp(
      title: 'BotToast Demo',
      navigatorObservers: [BotToastNavigatorObserver()],
      home: BotToastInit(  
          child: XxxxPage()
      ),
    );
```
to:
``` dart
///2.x.x version initialization method
///Wrap your MaterialApp with BotToastInit
BotToastInit(
  child:MaterialApp(
      title: 'BotToast Demo',
      navigatorObservers: [BotToastNavigatorObserver()],
      home: XxxxPage(),
  )
);
```

- Modify the `warpWidget` parameter of the `showEnhancedWidget` method (note that this step is not necessary, depending on whether you have used `showEnhancedWidget`, if not used, this step can be omitted)

change:
```dart
///1.x.x version
showEnhancedWidget(
  ...
  warpWidget:(widget)=>XxxWrap(child:widget);
  ...
)
```
to:
```dart
///2.x.x version
showEnhancedWidget(
  ...
  warpWidget:(cancel,widget)=>XxxWrap(child:widget);
  ...
)
```

<br>


###  📃Documentation
[Documentation](API.md)



