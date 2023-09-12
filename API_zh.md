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

**调用BotToast.showXxx都会返回一个CancelFunc函数,调用此函数将会提前关闭对应的Toast**

#### 通用参数说明
参数 | 说明
---- | --- 
toastBuilder | 生成需要显示的Widget的函数  (```typedef ToastBuilder = Widget Function(CancelFunc cancelFunc);```)
CancelFunc | 调用BotToast.showXxx都会返回此函数,调用此方法将会提前关闭对应的Toast
key | 代表此Toast的一个凭证,凭此key可以删除当前key所定义的Widget
groupKey | 代表此Toast在那个分组的key,
duration | 持续时间,如果为null则不会去定时关闭,如果不为null则在到达指定时间时自动关闭
crossPage | 是否跨页面显示,如果为true,则该Toast会跨越多个Route显示,如果为false则在当前Route发生变化时,会自动关闭该Toast,例如[Navigator.push]-[Navigator.pop]等
allowClick | 是否在该Toast显示时,能否正常点击触发事件
clickClose | 是否在点击屏幕触发事件时自动关闭该Toast
ignoreContentClick | 是否忽视ToastContext区域如果为true时,用户点击该ToastContext区域时,用户可以的点击事件可以正常到达到Page上,换一句话说就是透明的(即便是Toast背景颜色不是透明),如果为false,则情况反之
onlyOne | 表示是否该分组内是否在同一时间里只存在一个Toast,区分是哪一个组是按照[groupKey]来区分的
backgroundColor | MainContent区域的背景颜色
backButtonBehavior | 点击物理返回键的行为(在android上等同于物理的返回键),注意不是导航条上的返回按钮,如果为[BackButtonBehavior.ignore]则拦截返回事件,如果为[BackButtonBehavior.close]则关闭该toast,并且拦截事件停止冒泡,如果为null or [BackButtonBehavior.none]则不拦截事件

<br>

#### 1.BotToast.showSimpleNotification
##### 显示简单的通知Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
title | 是 | 无 | 标题
subTitle | 否 | 无| 副标题
dismissDirections | 否 | `[horizontal,up]` | 能进行滑动关闭的方向
animationDuration | 否 | `Duration(milliseconds: 256)` | [说明请看showAnimationWidget.animationDuration](#9bottoastshowanimationwidget)
animationReverseDuration | 否 | 无 | [说明请看showAnimationWidget.animationReverseDuration](#9bottoastshowanimationwidget)
wrapAnimation | 否 | 无 | [说明请看showAnimationWidget.wrapAnimation](#9bottoastshowanimationwidget)
wrapToastAnimation | 否 | `notificationAnimation` | [说明请看showAnimationWidget.wrapToastAnimation](#9bottoastshowanimationwidget)
align | 否 | `Alignment(0, -0.99)` | ToastContent区域在MainContent区域的对齐
onTap | 否 | 无 | 点击通知Toast的回调
onLongPress | 否 | 无 | 长按通知Toast的回调
closeIcon | 否 | 无|关闭按钮的图标
enableSlideOff | 否 | true| 是否能滑动删除
hideCloseButton | 否 | false| 是否隐藏关闭按钮
duration | 否 | ```Duration(seconds: 2)```| [duration说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
onlyOne | 否 | true| [onlyOne说明](#通用参数说明)
backButtonBehavior | 否 | 无 | [backButtonBehavior说明](#通用参数说明)
backgroundColor | No | ```Theme.of(context).cardColor```| ```Cards background color``` |
borderRadius | No | ```ThemeData.cardTheme.shape```| ```Cards border radius``` |
<br>

#### 2.BotToast.showNotification
##### 显示一个标准的通知Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
leading | 否 | 无 | 头部
title | 否 | 无 | 标题
subTitle | 否 | 无| 副标题
trailing | 否 | 无 | 尾部
dismissDirections | 否 | `[horizontal,up]` | 能进行滑动关闭的方向
animationDuration | 否 | `Duration(milliseconds: 256)` | [说明请看showAnimationWidget.animationDuration](#9bottoastshowanimationwidget)
animationReverseDuration | 否 | 无 | [说明请看showAnimationWidget.animationReverseDuration](#9bottoastshowanimationwidget)
wrapAnimation | 否 | 无 | [说明请看showAnimationWidget.wrapAnimation](#9bottoastshowanimationwidget)
wrapToastAnimation | 否 | `notificationAnimation` | [说明请看showAnimationWidget.wrapToastAnimation](#9bottoastshowanimationwidget)
align | 否 | `Alignment(0, -0.99)` | ToastContent区域在MainContent区域的对齐
onTap | 否 | 无| 点击通知Toast的回调
onLongPress | 否 | 无 | 长按通知Toast的回调
contentPadding | 否 | 无 | ToastContent区域的内补
margin | 否 | 无 | ToastContent区域的外间距
duration | 否 | ```Duration(seconds: 2)```| [duration说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
onlyOne | 否 | true| [onlyOne说明](#通用参数说明)
enableSlideOff | 否 | true| 是否能滑动删除
backButtonBehavior | 否 | 无 | [backButtonBehavior说明](#通用参数说明)
backgroundColor | No | ```Theme.of(context).cardColor```| ```Cards background color``` |
borderRadius | No | ```ThemeData.cardTheme.shape```| ```Cards border radius``` |

<br>

#### 3.BotToast.showCustomNotification
##### 显示一个自定义的通知Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
toastBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
dismissDirections | 否 | `[horizontal,up]` | 能进行滑动关闭的方向
animationDuration | 否 | `Duration(milliseconds: 256)` | [说明请看showAnimationWidget.animationDuration](#9bottoastshowanimationwidget)
animationReverseDuration | 否 | 无 | [说明请看showAnimationWidget.animationReverseDuration](#9bottoastshowanimationwidget)
wrapAnimation | 否 | 无 | [说明请看showAnimationWidget.wrapAnimation](#9bottoastshowanimationwidget)
wrapToastAnimation | 否 | `notificationAnimation` | [说明请看showAnimationWidget.wrapToastAnimation](#9bottoastshowanimationwidget)
align | 否 | `Alignment(0, -0.99)` | ToastContent区域在MainContent区域的对齐
enableSlideOff | 否 | true| 是否能滑动删除
duration | 否 | ```Duration(seconds: 2)```| [duration说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
onlyOne | 否 | true| [onlyOne说明](#通用参数说明)
backButtonBehavior | 否 | 无 | [backButtonBehavior说明](#通用参数说明)


<br>


#### 4.BotToast.showAttachedWidget
##### 显示一个定位Toast,该方法可以在某个Widget(一般是Button)或者给定一个offset周围显示

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
attachedBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
targetContext | 否 | 无| 目标Widget(一般是一个按钮),使用上一般会使用[Builder]包裹,来获取到BuildContext  ([target]和[targetContext] 只能二选一)
target | 否 | 无| 目标[Offset],该偏移是以屏幕左上角为原点来计算的  ([target]和[targetContext] 只能二选一)
animationDuration | 否 | `Duration(milliseconds: 150)` | [说明请看showAnimationWidget.animationDuration](#9bottoastshowanimationwidget)
animationReverseDuration | 否 | 无 | [说明请看showAnimationWidget.animationReverseDuration](#9bottoastshowanimationwidget)
wrapAnimation | 否 | 无 | [说明请看showAnimationWidget.wrapAnimation](#9bottoastshowanimationwidget)
wrapToastAnimation | 否 | `attachedAnimation` | [说明请看showAnimationWidget.wrapToastAnimation](#9bottoastshowanimationwidget)
preferDirection | 否 | 无| 偏好方向,如果在空间允许的情况下,会偏向显示在那边
verticalOffset | 否 | ```0```| 垂直偏移,如果实际显示的方向为水平居中则该参数无效
horizontalOffset| 否 | ```0```| 水平偏移,如果实际显示的方向为垂直居中则该参数无效
enableSafeArea | 否 | true | 如果为true则toast确保不会显示在app状态栏上面(意味着是安全的),false则反之 
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
animationDuration | 否 | `Duration(milliseconds: 256)` | [说明请看showAnimationWidget.animationDuration](#9bottoastshowanimationwidget)
animationReverseDuration | 否 | 无 | [说明请看showAnimationWidget.animationReverseDuration](#9bottoastshowanimationwidget)
wrapAnimation | 否 | 无 | [说明请看showAnimationWidget.wrapAnimation](#9bottoastshowanimationwidget)
wrapToastAnimation | 否 | `textAnimation` | [说明请看showAnimationWidget.wrapToastAnimation](#9bottoastshowanimationwidget)
align | 否 | `Alignment(0, 0.8)` | ToastContent区域在MainContent区域的对齐
contentColor | 否 | `Colors.black54` | ToastContent区域背景颜色
borderRadius | 否 | `BorderRadius.all(Radius.circular(8))` | ToastContent区域圆角
textStyle | 否 | `TextStyle(fontSize: 17, color: Colors.white)` | 字体样式
contentPadding | 否 | ```EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7)``` | ToastContent区域的内补
backgroundColor | 否 | ```Colors.transparent```| [backgroundColor说明](#通用参数说明)
duration | 否 | ```Duration(seconds: 2)```| [duration说明](#通用参数说明)
onlyOne | 否 | true| [onlyOne说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
clickClose | 否 | false| [clickClose说明](#通用参数说明)
backButtonBehavior | 否 | 无 | [backButtonBehavior说明](#通用参数说明)

<br>

#### 6.BotToast.showCustomText
##### 显示一个自定义的文本Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
toastBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
animationDuration | 否 | `Duration(milliseconds: 256)` | [说明请看showAnimationWidget.animationDuration](#9bottoastshowanimationwidget)
animationReverseDuration | 否 | 无 | [说明请看showAnimationWidget.animationReverseDuration](#9bottoastshowanimationwidget)
wrapAnimation | 否 | 无 | [说明请看showAnimationWidget.wrapAnimation](#9bottoastshowanimationwidget)
wrapToastAnimation | 否 | `textAnimation` | [说明请看showAnimationWidget.wrapToastAnimation](#9bottoastshowanimationwidget)
align | 否 | `Alignment(0, 0.8)` | ToastContent区域在MainContent区域的对齐
duration | 否 | ```Duration(seconds: 2)```| [duration说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
onlyOne | 否 | false| [onlyOne说明](#通用参数说明)
clickClose | 否 | false| [clickClose说明](#通用参数说明)
ignoreContentClick | 否 | false| [ignoreContentClick说明](#通用参数说明)
backgroundColor | 否 | ```Colors.transparent```| [backgroundColor说明](#通用参数说明)
backButtonBehavior | 否 | 无 | [backButtonBehavior说明](#通用参数说明)

<br>

#### 7.BotToast.showLoading
##### 显示一个标准的加载Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
animationDuration | 否 | `Duration(milliseconds: 300)` | [说明请看showAnimationWidget.animationDuration](#9bottoastshowanimationwidget)
animationReverseDuration | 否 | 无 | [说明请看showAnimationWidget.animationReverseDuration](#9bottoastshowanimationwidget)
wrapAnimation | 否 | `loadingAnimation` | [说明请看showAnimationWidget.wrapAnimation](#9bottoastshowanimationwidget)
wrapToastAnimation | 否 | 无 | [说明请看showAnimationWidget.wrapToastAnimation](#9bottoastshowanimationwidget)
align | 否 | `Alignment.center` | ToastContent区域在MainContent区域的对齐
duration | 否 | 无| [duration说明](#通用参数说明)
crossPage | 否 | true| [crossPage说明](#通用参数说明)
clickClose | 否 | false| [clickClose说明](#通用参数说明)
allowClick | 否 | false| [allowClick说明](#通用参数说明)
backgroundColor | 否 | ```Colors.black26```| [backgroundColor说明](#通用参数说明)
backButtonBehavior | 否 | 无 | [backButtonBehavior说明](#通用参数说明)

<br>


#### 8.BotToast.showCustomLoading
##### 显示一个自定义的加载Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
toastBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
animationDuration | 否 | `Duration(milliseconds: 300)` | [说明请看showAnimationWidget.animationDuration](#9bottoastshowanimationwidget)
animationReverseDuration | 否 | 无 | [说明请看showAnimationWidget.animationReverseDuration](#9bottoastshowanimationwidget)
wrapAnimation | 否 | `loadingAnimation` | [说明请看showAnimationWidget.wrapAnimation](#9bottoastshowanimationwidget)
wrapToastAnimation | 否 | 无 | [说明请看showAnimationWidget.wrapToastAnimation](#9bottoastshowanimationwidget)
align | 否 | `Alignment.center` | ToastContent区域在MainContent区域的对齐
ignoreContentClick | 否 | false| [ignoreContentClick说明](#通用参数说明)
clickClose | 否 | false| [clickClose说明](#通用参数说明)
allowClick | 否 | false| [allowClick说明](#通用参数说明)
crossPage | 否 | false| [crossPage说明](#通用参数说明)
duration | 否 | 无| [duration说明](#通用参数说明)
backgroundColor | 否 | ```Colors.black26```| [backgroundColor说明](#通用参数说明)
backButtonBehavior | 否 | 无 | [backButtonBehavior说明](#通用参数说明)

<br>

#### 9.BotToast.showAnimationWidget
##### 显示一个使用了Animation的Toast

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
toastBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
animationDuration | 是 | 无 | 正向动画的持续时间,其含义等同于[AnimationController.duration],值得注意的是建议不要超过[duration]
animationReverseDuration | 否 | 无 | 反向动画的持续时间,其含义等同于[AnimationController.reverseDuration]
wrapAnimation | 否 | 无 | 包装`MainConten`t区域的动画,可用于自定义动画,如果为null则表示不需要动画,使用这个函数不意味着一定要使用动画,可以额外做一些包装`widget`的处理,与`wrapToastAnimation`最大的区别就是处理的范围不一样
wrapToastAnimation | 否 | 无 | 包装`ToastContent`区域的动画,可用于自定义动画,如果为null则表示不需要动画,使用这个函数不意味着一定要使用动画,可以额外做一些包装`Widget`的处理,与`wrapAnimation`最大的区别就是处理的范围不一样
key | 否 | 无|[key说明](#通用参数说明)
groupKey | 否 | 无|[groupKey说明](#通用参数说明)
ignoreContentClick | 否 | false| [ignoreContentClick说明](#通用参数说明)
clickClose | 否 | false| [clickClose说明](#通用参数说明)
onlyOne | 否 | false| [onlyOne说明](#通用参数说明)
allowClick | 否 | true| [allowClick说明](#通用参数说明)
crossPage | 否 | true| [说明请看showEnhancedWidget.crossPage](#10bottoastshowenhancedwidget)
closeFunc | 否 | 无 | [说明请看showEnhancedWidget.closeFunc](#10bottoastshowenhancedwidget)
warpWidget | 否 | 无 | [warpWidget说明](#10bottoastshowenhancedwidget)
duration | 否 | 无| [duration说明](#通用参数说明)
backgroundColor | 否 | ```Colors.transparent```| [backgroundColor说明](#通用参数说明)
backButtonBehavior | 否 | 无 | [backButtonBehavior说明](#通用参数说明)

<br>

#### 10.BotToast.showEnhancedWidget
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
backButtonBehavior | 否 | 无 | [backButtonBehavior说明](#通用参数说明)

<br>

#### 11.BotToast.showWidget
##### 显示一个Widget在屏幕上,该Widget可以跨多个页面存在

参数 | 是否必须 |默认值| 说明
---- | --- | ---|----
toastBuilder | 是 | 无 | [toastBuilder说明](#通用参数说明)
key | 否 | 无|[key说明](#通用参数说明)
groupKey | 否 | 无|[groupKey说明](#通用参数说明)
