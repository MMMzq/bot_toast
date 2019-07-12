import 'package:flutter/material.dart';
import 'basis.dart';
import 'key_board_safe_area.dart';
import 'package:flutter/scheduler.dart';

import 'toast_navigator_observer.dart';

part 'toast_widget.dart';

part 'bot_toast_manager.dart';

void _safeRun(void Function() callback) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    callback();
  });
  SchedulerBinding.instance.scheduleFrame();
}

///todo
///不要调用[ToastBuilder]方法生成widget时,
///请注意该生成的Widget不会吸收背景不会吸收点击事件
///例如[Scaffold],[Material]都会默认占满整个父空间,
///并且会吸收事件,具体例子可看[material.dart->_RenderInkFeatures class->hitTestSelf method]
///如果真的要生成,可以考虑使用[IgnorePointer].
///如果没有遵守规则,将会时某些功能失效例如[allowClick]功能就会失效
class BotToast {
  static GlobalKey<_BotToastManagerState> _managerState;
  static const String textKey = "_textKey";
  static const String notificationKey = "_notificationKey";
  static const String loadKey = "_loadKey";
  static const String attachedKey = "_attachedKey";
  static const String defaultKey = "_defaultKey";

  static final List<CancelFunc> cacheNotification = [];
  static final Map<String, List<CancelFunc>> cacheCancelFunc = {
    textKey: [],
    notificationKey: [],
    loadKey: [],
    attachedKey: [],
    defaultKey: [],
  };

  ///此方法暂时不能多次初始化!
  static init(BuildContext context) {
    _safeRun(() {
      assert(_managerState == null, "不允许初始化多次!");
      (context.ancestorWidgetOfExactType(MaterialApp) as MaterialApp).navigatorObservers.add(BotToastNavigatorObserver());
      _managerState = GlobalKey<_BotToastManagerState>();
      Overlay.of(context).insert(OverlayEntry(builder: (_) {
        return _BotToastManager(
          key: _managerState,
        );
      }));
    });
  }

  static CancelFunc showSimpleNotification(
      {@required String title,
      String subTitle,
      Duration duration = const Duration(seconds: 2),
      bool enableSlideOff = true,
      bool hideCloseButton = false,
      bool crossPage = true,
      bool onlyOne = true}) {
    return showNotification(
        duration: duration,
        enableSlideOff: enableSlideOff,
        onlyOne: onlyOne,
        crossPage: crossPage,
        hideCloseButton: hideCloseButton,
        title: (_) => Text(title),
        subtitle: subTitle == null ? null : (_) => Text(subTitle),
        trailing: (cancel) =>
            IconButton(icon: Icon(Icons.cancel), onPressed: cancel));
  }

  static CancelFunc showNotification(
      {ToastBuilder leading,
      ToastBuilder title,
      ToastBuilder subtitle,
      ToastBuilder trailing,
      Duration duration = const Duration(seconds: 2),
      EdgeInsetsGeometry contentPadding,
      bool enableSlideOff = true,
      bool crossPage = true,
      bool hideCloseButton = false,
      bool onlyOne = true}) {
    return showCustomNotification(
        enableSlideOff: enableSlideOff,
        onlyOne: onlyOne,
        crossPage: crossPage,
        duration: duration,
        toastBuilder: (cancel) {
          return Card(
            child: ListTile(
                contentPadding: contentPadding,
                leading: leading?.call(cancel),
                title: title?.call(cancel),
                subtitle: subtitle?.call(cancel),
                trailing: hideCloseButton ? null : trailing?.call(cancel)),
          );
        });
  }

  static CancelFunc showCustomNotification(
      {@required ToastBuilder toastBuilder,
      Duration duration = const Duration(seconds: 2),
      bool enableSlideOff = true,
      bool crossPage = true,
      bool onlyOne = true}) {
    final key = GlobalKey<NormalAnimationState>();

    CancelFunc cancelAnimationFunc;

    CancelFunc cancelFunc = showEnhancedWidget(
        crossPage: crossPage,
        allowClick: true,
        clickClose: false,
        ignoreContentClick: false,
        onlyOne: onlyOne,
        duration: duration,
        toastBuilder: (cancelFunc) => NormalAnimation(
              key: key,
              reverse: true,
              child: _NotificationToast(
                  child: toastBuilder(cancelAnimationFunc),
                  slideOffFunc: enableSlideOff ? cancelFunc : null),
            ),
        groupKey: notificationKey);

    cancelAnimationFunc = () async {
      await key.currentState?.hide();
      cancelFunc();
    };

    return cancelAnimationFunc;
  }

  ///[text] 需要显示的文本
  ///[duration] 持续时间
  ///[clickClose] 是否允许用户提前点击页面关闭Toast
  ///[CancelFunc] 关闭函数,主动调用将会关闭此Toast
  ///如果此方法的样式不符合,可以使用showWidget参照此方法定义一个
  static CancelFunc showText(
      {@required String text,
      Color backgroundColor = Colors.transparent,
      Color contentColor = Colors.black54,
      BorderRadiusGeometry borderRadius =
          const BorderRadius.all(Radius.circular(8)),
      TextStyle textStyle = const TextStyle(fontSize: 17, color: Colors.white),
      AlignmentGeometry align = const Alignment(0, 0.8),
      EdgeInsetsGeometry contentPadding =
          const EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7),
      Duration duration = const Duration(seconds: 2),
      bool clickClose = false,
        bool crossPage = true,

        bool onlyOne = false}) {
    return showCustomText(
        duration: duration,
        crossPage: crossPage,
        backgroundColor: backgroundColor,
        clickClose: clickClose,
        onlyOne: onlyOne,
        toastBuilder: (_) => _TextToast(
              contentPadding: contentPadding,
              contentColor: contentColor,
              borderRadius: borderRadius,
              textStyle: textStyle,
              align: align,
              text: text,
            ));
  }

  ///[text] 需要显示的文本
  ///[duration] 持续时间
  ///[clickClose] 是否允许用户提前点击页面关闭Toast
  ///[CancelFunc] 关闭函数,主动调用将会关闭此Toast
  ///如果此方法的样式不符合,可以使用showWidget参照此方法定义一个
  static CancelFunc showCustomText(
      {@required ToastBuilder toastBuilder,
      Color backgroundColor = Colors.transparent,
      Duration duration = const Duration(seconds: 2),
      bool crossPage = true,
      bool clickClose = false,
      bool ignoreContentClick = false,
      bool onlyOne = false}) {
    final key = GlobalKey<NormalAnimationState>();

    CancelFunc cancelAnimationFunc;

    CancelFunc cancelFunc = showEnhancedWidget(
      groupKey: textKey,
      closeFunc: () => cancelAnimationFunc(),
      clickClose: clickClose,
      allowClick: true,
      onlyOne: onlyOne,
      crossPage: crossPage,
      ignoreContentClick: ignoreContentClick,
      backgroundColor: backgroundColor,
      duration: duration,
      toastBuilder: (_) => SafeArea(
              child: NormalAnimation(
            key: key,
            child: toastBuilder(cancelAnimationFunc),
          )),
    );

    //有动画的方式关闭
    cancelAnimationFunc = () async {
      await key.currentState?.hide();
      cancelFunc();
    };

    return cancelAnimationFunc;
  }

  ///[clickClose] 是否允许用户提前点击页面关闭Toast
  ///[allowClick] 使用允许用户可以点击页面,如果为true则用户可以正常触发事件,如果为false则用户的点击事件全都吸收掉
  ///[CancelFunc] 关闭函数,主动调用将会关闭此Toast
  ///如果此方法的样式不符合,可以使用showWidget参照此方法定义一个
  static CancelFunc showLoading({
    bool crossPage = true,
    bool clickClose = false,
    bool allowClick = false,
    Duration duration,
    Color backgroundColor = Colors.black26,
  }) {
    return showCustomLoading(
        loadWidget: (_) => _LoadingWidget(),
        clickClose: clickClose,
        allowClick: allowClick,
        crossPage: crossPage,
        ignoreContentClick: true,
        duration: duration,
        backgroundColor: backgroundColor);
  }

  static CancelFunc showCustomLoading({
    @required ToastBuilder loadWidget,
    bool clickClose = false,
    bool allowClick = false,
    bool ignoreContentClick = true,
    bool crossPage = false,
    Duration duration,
    Color backgroundColor = Colors.black26,
  }) {
    assert(loadWidget != null, "loadWidget not null");

    final key = GlobalKey<FadeAnimationState>();

    CancelFunc cancelAnimationFunc;

    CancelFunc cancelFunc = showEnhancedWidget(
        groupKey: loadKey,
        toastBuilder: (_) => SafeArea(child: loadWidget(cancelAnimationFunc)),
        warpWidget: (child) => FadeAnimation(
              key: key,
              child: child,
            ),
        clickClose: clickClose,
        allowClick: allowClick,
        crossPage: crossPage,
        ignoreContentClick: ignoreContentClick,
        onlyOne: false,
        duration: duration,
        closeFunc: () => cancelAnimationFunc(),
        backgroundColor: backgroundColor);

    cancelAnimationFunc = () async {
      await key.currentState?.hide();
      cancelFunc();
    };

    return cancelAnimationFunc;
  }

  ///此方法一般使用在dispose里面,防止因为开发人员没有主动去关闭,或者是请求api时的出现异常
  ///导致CancelFunc方法没有执行到等等,导致用户点击不了app
  static void closeAllLoading() {
    //以此方式移除将不会触发关闭动画
    removeAll(loadKey);
  }

  static CancelFunc showAttachedWidget({
    @required ToastBuilder attachedWidget,
    BuildContext targetContext,
    Color backgroundColor = Colors.transparent,
    Offset target,
    double verticalOffset = 24,
    Duration duration,
    PreferDirection preferDirection,
    bool ignoreContentClick = false,
    bool onlyOne = false,
    bool allowClick = true,
    bool crossPage = false,
  }) {
    assert(!(targetContext != null && target != null),
        "targetContext and target cannot coexist");
    assert(targetContext != null || target != null,
        "targetContext and target must exist one");

    if (target == null) {
      RenderObject renderObject = targetContext.findRenderObject();
      if (renderObject is RenderBox) {
        target =
            renderObject.localToGlobal(renderObject.size.center(Offset.zero));
      } else {
        throw Exception(
            "context.findRenderObject() return result must be RenderBox class");
      }
    }
    GlobalKey<FadeAnimationState> key = GlobalKey<FadeAnimationState>();

    CancelFunc cancelAnimationFunc;

    CancelFunc cancelFunc = showEnhancedWidget(
        allowClick: allowClick,
        clickClose: true,
        groupKey: attachedKey,
        crossPage: crossPage,
        onlyOne: onlyOne,
        backgroundColor: backgroundColor,
        ignoreContentClick: ignoreContentClick,
        closeFunc: () => cancelAnimationFunc(),
        warpWidget: (widget) => FadeAnimation(
              child: widget,
              key: key,
              duration: Duration(milliseconds: 150),
            ),
        duration: duration,
        toastBuilder: (_) => CustomSingleChildLayout(
              delegate: PositionDelegate(
                  target: target,
                  verticalOffset: verticalOffset ?? 0,
                  preferDirection: preferDirection),
              child: attachedWidget(cancelAnimationFunc),
            ));

    cancelAnimationFunc = () async {
      await key.currentState?.hide();
      cancelFunc();
    };

    return cancelAnimationFunc;
  }

  /*
    _________________________________
   |          MainContent            |
   |                      <----------------------allowClick
   |                      <----------------------clickClose
   |      ___________________        |
   |     |                   |       |
   |     |    ToastContent   |       |
   |     |                <----------------------ignoreContentClick
   |     |___________________|       |
   |_________________________________|
   */

  static CancelFunc showEnhancedWidget(
      {@required ToastBuilder toastBuilder,
      UniqueKey key,
      String groupKey,
      bool crossPage = true,
      bool allowClick = true,
      bool clickClose = false,
      bool ignoreContentClick = false,
      bool onlyOne = false,
      CancelFunc closeFunc,
      Color backgroundColor = Colors.transparent,
      WrapWidget warpWidget,
      Duration duration}) {
    //由于dismissFunc一开始是为空的,所以在赋值之前需要在闭包里使用
    CancelFunc dismissFunc;

    List<CancelFunc> cache = cacheCancelFunc[groupKey ?? defaultKey] ??= [];
    if (onlyOne) {
      cache.forEach((cancel) => cancel());
      cache.clear();
    }
    VoidCallback rememberFunc = () => dismissFunc();
    cache.add(rememberFunc);

    print(cache.length);

    CancelFunc cancelFunc = showWidget(
        groupKey: groupKey,
        key: key,
        toastBuilder: (cancel) {
          return KeyBoardSafeArea(
            child: ProxyDispose(disposeCallback: () {
              cache.remove(rememberFunc);
            }, child: Builder(
              builder: (BuildContext context) {
                TextStyle textStyle = Theme.of(context).textTheme.body1;
                Widget child = DefaultTextStyle(
                    style: textStyle,
                    child: Stack(
                      children: <Widget>[
                        Listener(
                          onPointerDown:
                              clickClose ? (_) => dismissFunc() : null,
                          behavior: allowClick
                              ? HitTestBehavior.translucent
                              : HitTestBehavior.opaque,
                          child: SizedBox.expand(),
                        ),
                        IgnorePointer(
                          child: Container(color: backgroundColor),
                        ),
                        IgnorePointer(
                          ignoring: ignoreContentClick,
                          child: toastBuilder(cancel),
                        )
                      ],
                    ));
                return warpWidget != null ? warpWidget(child) : child;
              },
            )),
          );
        });

    dismissFunc = closeFunc ?? cancelFunc;

    if (!crossPage) {
      BotToastNavigatorObserver.instance.runOnce(cancelFunc);
    }

    if (duration != null) {
      Future.delayed(duration, () {
        (closeFunc ?? cancelFunc)();
      });
    }

    return cancelFunc;
  }

  ///[widget] 需要显示的Widget
  ///[key] 代表此Toast的一个凭证,凭此key可以删除当前key所定义的Widget,[remove]
  ///[groupKey] 代表分组的key,主要用于[removeAll]和[remove]
  ///[CancelFunc] 关闭函数,主动调用将会关闭此Toast
  ///这是个核心方法
  static CancelFunc showWidget(
      {@required ToastBuilder toastBuilder, UniqueKey key, String groupKey}) {
    assert(toastBuilder != null);
    final gk = groupKey ?? defaultKey;
    final uniqueKey = key ?? UniqueKey();
    final CancelFunc cancelFunc = () {
      remove(uniqueKey, gk);
    };
    _safeRun(() {
      /*
      如果currentState为空说明此时BotToast还没初始化完成,此时的状态是处理showWidget和init方法都是是在同一帧里,
      因此要把showWidget方法放在下一帧处理
      */
      if (_managerState.currentState == null) {
        _safeRun(() {
          _managerState.currentState
              .insert(gk, uniqueKey, toastBuilder(cancelFunc));
        });
      } else {
        _managerState.currentState
            .insert(gk, uniqueKey, toastBuilder(cancelFunc));
      }
    });
    return cancelFunc;
  }

  static void remove(UniqueKey key, [String groupKey]) {
    _safeRun(() {
      _managerState.currentState.remove(groupKey ?? defaultKey, key);
    });
  }

  static void removeAll([String groupKey]) {
    _safeRun(() {
      _managerState.currentState.removeAll(groupKey ?? defaultKey);
    });
  }

  static void cleanAll() {
    _safeRun(() {
      _managerState.currentState.cleanAll();
    });
  }
}
