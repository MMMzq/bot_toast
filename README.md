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
``` dart
dependencies:
     bot_toast: 0.0.2
```

#### 2. 导入BotToast库
``` dart
import 'package:bot_toast/bot_toast.dart';
```

#### 3. 添加BotToastInit
``` dart
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
``` dart
BotToast.showText(text:"xxxx")  //弹出一个文本框;
```

```
final cancel=BotToast.showLoading(); //弹出一个加载动画
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

### 🐹主要Api文档

#### 1. BotToast.showText
##### 弹出文本框 (如果样式不符合你的需求,可参照此方法自定义一个,很简单)

参数 | 是否必须 | 说明
---- | --- | ---
text | 是 | 需要显示的文本
duration | 否 | 持续时间
clickClose | 否 | 是否允许用户提前点击页面关闭Toast

<br>

#### 2. BotToast.showLoading
##### 弹出一个加载动画 (如果样式不符合你的需求,可参照此方法自定义一个,很简单)

参数 | 是否必须 | 说明
---- | --- | ---
clickClose | 否 | 是否允许用户提前点击页面关闭Toast
allowClick | 否 | 使用允许用户可以点击页面,如果为true则用户可以正常触发事件,如果为false则用户的点击事件全都吸收掉

<br>

#### 3. BotToast.closeAllLoading
##### 关闭所有加载动画

不需要任何参数

<br>

#### 4.BotToast.showWidget
##### 弹出一个给定的Widget (BotToast.showText和BotToast.showLoading都是基于此方法编写的)

参数 | 是否必须 | 说明
---- | --- | ---
widget | 是 | 需要显示的Widget
key | 否 | 代表此Toast的一个凭证,凭此key可以删除当前key所定义的Widget
groupKey | 否 | 代表分组的key,主要用于[BotToast.removeAll]和[BotToast.remove]


