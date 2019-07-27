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
* 增强showAttachedWidget方法,支持更多方向,并且定位的更准确了
* showAttachedWidget方法添加了horizontalOffset参数来控制水平偏移
* PreferDirection的Below,Upside(被删除了),现在枚举值更加直观