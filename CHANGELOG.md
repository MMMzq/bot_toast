## [2.0.0]
* 修改了初始化的方式现在更为通用

* 支持自定义Toast的**动画**和持续时间😉

* `showEnhancedWidget`方法的`closeFunc`参数其含义已经发生了变化了,现在是等待`closeFunc`函数执行完毕才移除Toast

* 添加`showAnimationWidget`方法,可以使用这个方法来高度自定义一个有动画的Toast🤩

* 移除`reInit`方法(2.0版本不再需要),以及`PreferDirection.Below`和`PreferDirection.Upside`这两个已经被废除的枚举

* `WrapWidget`类型方法参数发生变化(破坏性的),但是如果你没有直接使用`showEnhancedWidget`方式的话,这个修改对1.x版本的代码其实是无影响的

* `showXxxNotification` 添加`dismissDirections`参数:表示能进行滑动关闭的方向 

* `showXxxText`,`showXxxLoading`,`showXxxNotification`等方法添加了`align`参数:表示ToastContent区域在MainContent区域的对齐,可用于自定义Toast放置的位置

* 修复了`showAttachedWidget`方法的一些bug

* 支持flutter web(注意不能确保其稳定性)

* 更新example的样式,并添加了更多demo


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
