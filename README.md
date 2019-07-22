BotToast ❤
========= 
[![](https://img.shields.io/pub/v/bot_toast.svg?label=bot_toast&logo=https%3A%2F%2Fpub.flutter-io.cn%2Fpackages%2Fbot_toast)](https://pub.flutter-io.cn/packages/bot_toast)

## 一个真正意义上的flutter Toast库!

###  🐶特点

- 真正意义上的Toast,可以在任何你需要的时候调用,不会有任何限制! (这是他最重要的特点,跟别的Toast库不同的地方)

- 功能丰富,支持显示通知,文本,加载,附属等类型Toast

- 支持在弹出各种自定义Toast,或者说你可以弹出任何Widget,只要它符合flutter代码的要求即可

- Api简单易用,基本上没有必要参数(包括BuildContext),基本上都是可选参数

- 纯flutter实现,不容易带来兼容问题

### 🐼例子

[在线例子(Online demo)](https://mmmzq.github.io/bot_toast/#/) (Web效果可能有偏差,真实效果请以手机端为准)

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
     bot_toast: 1.0.3
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


### 🐹主要Api文档

#### 区域图

```
  _________________________________
|          MainContent            |
|                                 |
|                                 |
|      ___________________        |
|     |                   |       |
|     |    ToastContent   |       |
|     |___________________|       |
|_________________________________|
```

#### 通用参数说明
参数 | 说明
---- | --- 
toastBuilder | 生成需要显示的Widget的函数  (```typedef ToastBuilder = Widget Function(CancelFunc cancelFunc);```)
key | 代表此Toast的一个凭证,凭此key可以删除当前key所定义的Widget
groupKey | 代表此Toast在那个分组的key,
duration | 持续时间,如果为null则不会去定时关闭,如果不为null则在到达指定时间时自动关闭
crossPage | 是否跨页面显示,如果为true,则该Toast会跨越多个Route显示,如果为false则在当前Route发生变化时,会自动关闭该Toast,例如[Navigator.push]-[Navigator.pop]等
allowClick | 是否在该Toast显示时,能否正常点击触发事件
clickClose | 是否在点击屏幕触发事件时自动关闭该Toast
ignoreContentClick | 是否忽视ToastContext区域如果为true时,用户点击该ToastContext区域时,用户可以的点击事件可以正常到达到Page上,换一句话说就是透明的(即便是Toast背景颜色不是透明),如果为false,则情况反之
onlyOne | 表示是否该分组内是否在同一时间里只存在一个Toast,区分是哪一个组是按照[groupKey]来区分的
backgroundColor | MainContent区域的背景颜色

<br>

#### 1.BotToast.showSimpleNotification
##### 显示简单的通知Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
title | 是 | 无 | 标题
subTitle | 否 | 无| 副标题
closeIcon | 否 | 无|关闭按钮的图标
enableSlideOff | 否 | true| 是否能滑动删除
hideCloseButton | 否 | false| 是否隐藏关闭按钮
duration | 否 | ```Duration(seconds: 2)```| [duration说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
onlyOne | 否 | true| [onlyOne说明](#通用参数说明)

<br>

#### 2.BotToast.showNotification
##### 显示一个标准的通知Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
leading | 否 | 无 | 头部
title | 否 | 无 | 标题
subTitle | 否 | 无| 副标题
trailing | 否 | 无 | 尾部
contentPadding | 否 | 无 | ToastContent区域的内补
duration | 否 | ```Duration(seconds: 2)```| [duration说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
onlyOne | 否 | true| [onlyOne说明](#通用参数说明)
enableSlideOff | 否 | true| 是否能滑动删除

<br>

#### 3.BotToast.showCustomNotification
##### 显示一个自定义的通知Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
toastBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
enableSlideOff | 否 | true| 是否能滑动删除
duration | 否 | ```Duration(seconds: 2)```| [duration说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
onlyOne | 否 | true| [onlyOne说明](#通用参数说明)

<br>


#### 4.BotToast.showAttachedWidget
##### 显示一个定位Toast,该方法可以在某个Widget(一般是Button)或者给定一个offset周围显示

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
attachedBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
targetContext | 否 | 无| 目标Widget(一般是一个按钮),使用上一般会使用[Builder]包裹,来获取到BuildContext  ([target]和[targetContext] 只能二选一)
target | 否 | 无| 目标[Offset],该偏移是以屏幕左上角为原点来计算的  ([target]和[targetContext] 只能二选一)
preferDirection | 否 | 无| 偏好方向,如果在空间允许的情况下,会偏向显示在那边
verticalOffset | 否 | ```24```| 垂直偏移跟[preferDirection]有关,根据不同的方向会作用在不用的方向上
duration | 否 | 无| [duration说明](#通用参数说明)
onlyOne | 否 | false| [onlyOne说明](#通用参数说明)
allowClick | 否 | true| [allowClick说明](#通用参数说明)
ignoreContentClick | 否 | false| [ignoreContentClick说明](#通用参数说明)
backgroundColor | 否 | ```Colors.transparent```| [backgroundColor说明](#通用参数说明)

<br>


#### 5.BotToast.showText
##### 显示一个标准文本Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
text | 是 | 无 | 需要显示的文本
contentColor | 否 | `Colors.black54` | ToastContent区域背景颜色
borderRadius | 否 | `BorderRadius.all(Radius.circular(8))` | ToastContent区域圆角
textStyle | 否 | `TextStyle(fontSize: 17, color: Colors.white)` | 字体样式
align | 否 | `Alignment(0, 0.8)` | ToastContent区域在MainContent区域的对齐
contentPadding | 否 | ```EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7)``` | ToastContent区域的内补
backgroundColor | 否 | ```Colors.transparent```| [backgroundColor说明](#通用参数说明)
duration | 否 | ```Duration(seconds: 2)```| [duration说明](#通用参数说明)
onlyOne | 否 | true| [onlyOne说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
clickClose | 否 | false| [clickClose说明](#通用参数说明)

<br>

#### 6.BotToast.showCustomText
##### 显示一个自定义的文本Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
toastBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
duration | 否 | ```Duration(seconds: 2)```| [duration说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
onlyOne | 否 | false| [onlyOne说明](#通用参数说明)
clickClose | 否 | false| [clickClose说明](#通用参数说明)
ignoreContentClick | 否 | false| [ignoreContentClick说明](#通用参数说明)
backgroundColor | 否 | ```Colors.transparent```| [backgroundColor说明](#通用参数说明)

<br>

#### 7.BotToast.showLoading
##### 显示一个标准的加载Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
duration | 否 | 无| [duration说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
clickClose | 否 | false| [clickClose说明](#通用参数说明)
allowClick | 否 | false| [allowClick说明](#通用参数说明)
backgroundColor | 否 | ```Colors.black26```| [backgroundColor说明](#通用参数说明)

<br>


#### 8.BotToast.showCustomLoading
##### 显示一个自定义的加载Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
toastBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
ignoreContentClick | 否 | false| [ignoreContentClick说明](#通用参数说明)
clickClose | 否 | false| [clickClose说明](#通用参数说明)
allowClick | 否 | false| [allowClick说明](#通用参数说明)
crossPage | 否 | false| [crossPage说明](#通用参数说明)
duration | 否 | 无| [duration说明](#通用参数说明)
backgroundColor | 否 | ```Colors.black26```| [backgroundColor说明](#通用参数说明)

<br>

#### 9.BotToast.showEnhancedWidget
##### 显示一个增强Toast,该方法可以让Toast自带很多特性,例如定时关闭,点击屏幕自动关闭,离开当前Route关闭等等

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
toastBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
key | 否 | 无|[key说明](#通用参数说明)
groupKey | 否 | 无|[groupKey说明](#通用参数说明)
ignoreContentClick | 否 | false| [ignoreContentClick说明](#通用参数说明)
clickClose | 否 | false| [clickClose说明](#通用参数说明)
onlyOne | 否 | false| [onlyOne说明](#通用参数说明)
allowClick | 否 | true| [allowClick说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
closeFunc | 否 | 无 | 该函数参数主要目的使Toast关闭之做一些处理例如触发关闭前调用[AnimationController]来启动并等待动画后再关闭
warpWidget | 否 | 无 | 一个wrap函数,可以用来warp MainContent区域,例如[showCustomLoading]就包裹了一个动画让MainContent区域也具有动画
duration | 否 | 无| [duration说明](#通用参数说明)
backgroundColor | 否 | ```Colors.transparent```| [backgroundColor说明](#通用参数说明)

<br>

#### 10.BotToast.showWidget
##### 显示一个Widget在屏幕上,该Widget可以跨多个页面存在

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
toastBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
key | 否 | 无|[key说明](#通用参数说明)
groupKey | 否 | 无|[groupKey说明](#通用参数说明)


