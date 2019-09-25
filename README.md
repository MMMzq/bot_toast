BotToast 🤖
========= 
A really easy to use flutter toast library!

[![](https://img.shields.io/pub/v/bot_toast.svg?label=bot_toast&logo=https%3A%2F%2Fpub.flutter-io.cn%2Fpackages%2Fbot_toast)](https://pub.flutter-io.cn/packages/bot_toast)
[![Build Status](https://travis-ci.com/MMMzq/bot_toast.svg?branch=master)](https://travis-ci.com/MMMzq/bot_toast)
[![codecov](https://codecov.io/gh/MMMzq/bot_toast/branch/master/graph/badge.svg)](https://codecov.io/gh/MMMzq/bot_toast)

### Language: English | [中文简体](https://github.com/MMMzq/bot_toast/blob/master/README_zh.md)

* [🐲Overview](#Overview)
* [🐼Online Demo](#Online-Demo)
* [🐳Example](#Example)
* [🐺Renderings](#Renderings)
* [🐮Getting started](#Getting-started) 
* [📃Documentation](#Documentation) 

###  🐲Overview

- In the true sense of Toast, you can call it whenever you need it, without any restrictions! (This is his most important feature, different from other Toast libraries)

- Feature-rich, support for displaying notifications, text, loading, attachments, etc. Toast

- Support for popping up various custom Toasts, or you can pop up any Widget as long as it meets the requirements of the flutter code.

- Api is easy to use, basically has no necessary parameters (including BuildContext), basically all optional parameters

- Pure flutter implementation, it is not easy to bring compatibility problems

### 🐱2.0 Version

- Modified the initialization way, 1.x version upgrade to 2.0 modification needs manual modification to adapt。see -> [2.0 initialization](#Getting-started) 

- `reInit` is removed because this method is no longer needed in version 2.x

- PreferDirection.Below and PreferDirection.Upside have been officially removed

- Refactoring the code structure

- fix `showAttachedWidget` some bug

### 🐼Online Demo

**[Online demo](https://mmmzq.github.io/bot_toast/#/)** (Web effects may be biased, the actual effect is subject to the mobile phone)

### 🐳Example
**[Sample project](https://github.com/MMMzq/bot_toast/tree/master/example)**

### 🐺Renderings

Text|Attached
--------|-------
![Text](https://github.com/MMMzq/bot_toast/raw/master/doc/gif/text.gif)|![Attached](https://github.com/MMMzq/bot_toast/raw/master/doc/gif/attached.gif)

Loading|Notification 
--------|-------
![Loading](https://github.com/MMMzq/bot_toast/raw/master/doc/gif/loading.gif)|![Notification](https://github.com/MMMzq/bot_toast/raw/master/doc/gif/notification.gif)

### 🐮Getting started

#### 1. add dependencies into you project pubspec.yaml file
``` dart
dependencies:
     bot_toast: ^2.0.0
```

#### 2. import BotToast lib
``` dart
import 'package:bot_toast/bot_toast.dart';
```

#### 3. initialization BotToast

- 2.x.x版本初始化方式
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
- 1.x.x版本初始化方式
``` dart
///Like this, BotToast will automatically initialize
MaterialApp(
      title: 'BotToast Demo',
      navigatorObservers: [BotToastNavigatorObserver()],//1.registered route observer
      home: BotToastInit(  //2.wrap your Page with BotToastInit
          child: XxxxPage()
      ),
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

<br>


###  📃Documentation
[Documentation](https://github.com/MMMzq/bot_toast/blob/master/API.md)



