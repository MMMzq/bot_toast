## [4.1.3]
* fix: Modify Assertion Logic

## [4.1.2]
* fix: Fix the problem of nil judgment error

## [4.1.1]
* fix: Delete unused packages
* fix: Using bodyMedium instead of bodyText2

## [4.1.0]
* feat: Support global configuration
* docs: Add English API documentation and English comments

## [4.0.4]
* feat: Added margin param to showNotification

## [4.0.3]
* feat: Add safe area flag for custom options

## [4.0.2]
* fix: Support flutter 3.x

## [4.0.1]
* fix: #107

## [4.0.0+1]
* docs: Update CHANGELOG.md

## [4.0.0]
* refactor: Migrate to sound null safety 

## [3.0.5]
* fix: cancel the use of `nullOk` attribute  

* feat: optimize `toast` display sequence logic 

* feat: add options for users to style titles

## [3.0.4]
* fix:  The bug that `ProxyDispose.disposeCallback` callback cannot be triggered

## [3.0.3]
* feat: add `enableKeyboardSafeArea` option

## [3.0.2]
* fix bug: #73

## [3.0.1]
* Add two parameters: `backgroundColor` and `borderRadius` to `showSimpleNotification` and `showNotification` methods

## [3.0.0]
* Reimplemented the underlying initialization logic, the code is simpler and more general, and no longer depends on `Navigator`

* Modify the initialization method

## [2.4.1]
* bug fix

## [2.4.0]
* feat: Support to intercept click back button event

## [2.3.1]
* fix: bug [#43](https://github.com/MMMzq/bot_toast/issues/43)

## [2.3.0]
* feat: add onClose callback

## [2.2.1]
* bug fix: Use `safeRun` method to ensure normal running of `rearrange`

## [2.2.0]
* 重构底层的实现方式以规避一些隐晦的bug

* Refactor the underlying implementation to avoid some hidden bugs

## [2.1.1]
* showSimpleNotification和showNotification方法添加`onTap`,`onLongPress`参数

* showSimpleNotification and showNotification methods add `onTap`, `onLongPress` parameters

## [2.1.0]
* bug fix: see [#11](https://github.com/MMMzq/bot_toast/issues/11)

* 移除`BotToastInit`的`key`参数

* `BotToast.init`方法变为私有方法不再公开

* 重构了初始化的方式

* Remove the `key` parameter of `BotToastInit`

* `BotToast.init` method becomes private and no longer public

* Refactored the way to initialize


## [2.0.0+2]
* Update document

## [2.0.0+1]
* Delete useless print

## [2.0.0]
* 修改初始化的方式,现在更为通用

* 支持自定义Toast的**动画**和持续时间😉

* `showEnhancedWidget`方法的`closeFunc`参数其含义已经发生了变化了,现在是等待`closeFunc`函数执行完毕才移除Toast

* 添加`showAnimationWidget`方法,可以使用此方法来高度自定义一个有动画的Toast🤩

* 移除`reInit`方法(2.0版本不再需要),以及`PreferDirection.Below`和`PreferDirection.Upside`这两个已经被废除的枚举

* `WrapWidget`类型方法参数发生变化(破坏性的),但是如果你没有直接使用`showEnhancedWidget`方式的话,这个修改对1.x版本的代码其实是无影响的,如果有使用请看这里进行兼容[1.x版本升级到2.x版本](README_zh.md#1x版本升级到2x版本)

* `showXxxNotification` 添加`dismissDirections`参数:表示能进行滑动关闭的方向 

* `showXxxText`,`showXxxLoading`,`showXxxNotification`等方法添加了`align`参数:表示ToastContent区域在MainContent区域的对齐,可用于自定义Toast放置的位置

* 修复了`showAttachedWidget`方法的一些bug

* 支持flutter web(注意不能确保其稳定性)

* 更新example的样式,并添加了更多demo

<br>

* Modify the way of initialization, now more general

* Support for custom Toast **animation** and **animation duration**😉

* The meaning of the `closeFunc` parameter of the `showEnhancedWidget` method has changed. Now it is wait for the `closeFunc` function to complete before removing Toast.

* Add the `showAnimationWidget` method, you can use this method to highly customize an animated Toast🤩

* Remove the `reInit` method and the two deprecated enumerations `PreferDirection.Below` and `PreferDirection.Upside`

* `WrapWidget` type method parameter changed (not compatible with 1.x version),see [1.x version upgrade 2.x version ](README.md#1x-version-upgrade-to-2x-version)

* `showXxxNotification` Add `dismissDirections` parameter

* `showXxxText`, `showXxxLoading`, `showXxxNotification` method adds `align` parameter

* Fixed some bugs in the `showAttachedWidget` method

* Support flutter web (note that it cannot ensure its stability)

* Updated the style of example and added more demos

## [1.1.1]
* Bug fix:

The targetContext of the showAttachedWidget method causes a positioning error when it is inside the ScrollView.

showAttachedWidget方法的targetContext在ScrollView里面时导致定位出错

## [1.1.0]
* 主要对showAttachedWidget方法进行了增强,现在支持更多方向,定位更准确了。

* `PreferDirection.Below`和`PreferDirection.Upside`被废弃了,可以改用表达更清晰的topCenter,和bottomCenter来代替,且效果完全一致。这两个枚举将会在下个大版本被删除!

* `showAttachedWidget`的`preferDirection` 只是期望的方向,实际的位置可能因为空间不足而遭到调整

* 实际调整顺序可以拿`topLeft`来进行说明,如果上方空间不足则调整为`bottomLeft`,然后左边空间不足的话就再判断右边的空间是否充足,充足的话结果为`bottomRight`,不充足最终结果为`bottomCenter`

* 对于`preferDirection=xxxCenter`的情况,其交叉轴的偏移将会忽略

## [1.0.3]

* 修复当pop所有Route再push Route会出现Bug
* 加固了当项目使用MaterialApp.navigatorKey,能使用reInit重新初始化

## [1.0.2]

* 放宽init重复初始化检查的程度
* 替换scheduleFrame方法为ensureVisualUpdate

## [1.0.1]

* Toast关闭后,清理向BotToastNavigatorObserver注册的函数


## [1.0.0+2]

* 更新文档及在线例子


## [1.0.0+1]

* 更新文档及在线例子

## [1.0.0]

* 1.支持弹出Notification Toast
* 2.支持某个Widget 显示
* 3.对已有的功能进行重构,增强各个方法

## [0.0.2] 

* 添加Loading Toast

## [0.0.1] 

* 只是显示Widget到屏幕
