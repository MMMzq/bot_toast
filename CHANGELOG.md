## [0.0.1] 

* 只是显示Widget到屏幕

## [0.0.2] 

* 添加Loading Toast

## [1.0.0]

* 1.支持弹出Notification Toast
* 2.支持某个Widget 显示
* 3.对已有的功能进行重构,增强各个方法

## [1.0.0+1]

* 更新文档及在线例子

## [1.0.0+2]

* 更新文档及在线例子

## [1.0.1]

* Toast关闭后,清理向BotToastNavigatorObserver注册的函数

## [1.0.2]

* 放宽init重复初始化检查的程度
* 替换scheduleFrame方法为ensureVisualUpdate

## [1.0.3]

* 修复当pop所有Route再push Route会出现Bug
* 加固了当项目使用MaterialApp.navigatorKey,能使用reInit重新初始化

## [1.1.0]
* 主要对showAttachedWidget方法进行了增强,现在支持更多方向,定位更准确了。

* `PreferDirection.Below`和`PreferDirection.Upside`被废弃了,可以改用表达更清晰的topCenter,和bottomCenter来代替,且效果完全一致。这两个枚举将会在下个大版本被删除!

* `showAttachedWidget`的`preferDirection` 只是期望的方向,实际的位置可能因为空间不足而遭到调整

* 实际调整顺序可以拿`topLeft`来进行说明,如果上方空间不足则调整为`bottomLeft`,然后左边空间不足的话就再判断右边的空间是否充足,充足的话结果为`bottomRight`,不充足最终结果为`bottomCenter`

* 对于`preferDirection=xxxCenter`的情况,其交叉轴的偏移将会忽略