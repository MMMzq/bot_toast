import 'package:flutter/material.dart';
import 'key_board_safe_area.dart';
import 'package:flutter/scheduler.dart';

part 'toast_widget.dart';

part 'bot_toast_manager.dart';

typedef CancelFunc = void Function();
typedef ToastBuilder = Widget Function(CancelFunc cancelFunc);
typedef WrapWidget = Widget Function(Widget widget);

void _safeRun(void Function() callback) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    callback();
  });
  SchedulerBinding.instance.scheduleFrame();
}

class BotToast {
  static GlobalKey<_BotToastManagerState> _managerState;
  static const String textKey = "_textKey";
  static const String notificationKey = "_notificationKey";
  static const String loadKey = "_loadKey";
  static const String defaultKey = "_defaultKey";

  static final List<GlobalKey<NormalAnimationState>> cacheNotification = [];
  static final List<GlobalKey<NormalAnimationState>> cacheText = [];

  ///此方法暂时不能多次初始化!
  static init(BuildContext context) {
    _safeRun(() {
      assert(_managerState == null, "不允许初始化多次!");
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
      bool onlyOne = false}) {
    return showNotification(
        duration: duration,
        enableSlideOff: enableSlideOff,
        onlyOne: onlyOne,
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
      bool hideCloseButton = false,
      bool onlyOne = false}) {
    return showCustomNotification(
        enableSlideOff: enableSlideOff,
        onlyOne: onlyOne,
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
      bool onlyOne = false}) {
    final key = GlobalKey<NormalAnimationState>();
    _safeRun(() {
      if (onlyOne) {
        cacheNotification
            .forEach((globalKey) => globalKey.currentState?.hide());
        cacheNotification.clear();
      }
      cacheNotification.add(key);
    });

    CancelFunc cancelAnimationFunc;

    final cancelFunc = showWidget(
        toastBuilder: (cancelFunc) => NormalAnimation(
              key: key,
              reverse: true,
              disposeCallback: () {
                cacheNotification.remove(key);
              },
              child: _NotificationToast(
                  child: toastBuilder(cancelAnimationFunc),
                  slideOffFunc: enableSlideOff ? cancelFunc : null),
            ),
        groupKey: notificationKey);

    cancelAnimationFunc = () async {
      await key.currentState?.hide();
      cancelFunc();
    };

    if (duration != null) {
      Future.delayed(duration, cancelAnimationFunc);
    }
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
      bool onlyOne = false}) {
    return showCustomText(
        duration: duration,
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
      bool clickClose = false,
      bool ignoreContentClick = false,
      bool onlyOne = false}) {
    final key = GlobalKey<NormalAnimationState>();

    _safeRun(() {
      if (onlyOne) {
        cacheText.forEach((globalKey) => globalKey.currentState?.hide());
        cacheText.clear();
      }
      cacheText.add(key);
    });

    CancelFunc cancelAnimationFunc;

    final cancelFunc = showEnhancedWidget(
      groupKey: textKey,
      closeFunc: () => cancelAnimationFunc(),
      clickClose: clickClose,
      allowClick: true,
      ignoreContentClick: ignoreContentClick,
      backgroundColor: backgroundColor,
      duration: duration,
      toastBuilder: (_) => NormalAnimation(
            key: key,
            disposeCallback: () {
              cacheNotification.remove(key);
            },
            child: toastBuilder(cancelAnimationFunc),
          ),
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
    bool clickClose = false,
    bool allowClick = false,
    Duration duration,
    Color backgroundColor = Colors.black26,
  }) {
    return showCustomLoading(
        loadWidget: (_) => _LoadingWidget(),
        clickClose: clickClose,
        allowClick: allowClick,
        duration: duration,
        backgroundColor: backgroundColor);
  }

  static CancelFunc showCustomLoading({
    @required ToastBuilder loadWidget,
    bool clickClose = false,
    bool allowClick = false,
    bool ignoreContentClick = true,
    Duration duration,
    Color backgroundColor = Colors.black26,
  }) {
    assert(loadWidget != null, "loadWidget not null");

    final key = GlobalKey<_LoadAnimationState>();

    CancelFunc cancelAnimationFunc;

    CancelFunc cancelFunc = showEnhancedWidget(
        groupKey: loadKey,
        toastBuilder: (_) => loadWidget(cancelAnimationFunc),
        warpWidget: (child) => LoadAnimation(
              key: key,
              child: child,
            ),
        clickClose: clickClose,
        allowClick: allowClick,
        duration: duration,
        closeFunc: () => cancelAnimationFunc(),
        ignoreContentClick: ignoreContentClick,
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

  static CancelFunc showEnhancedWidget(
      {@required ToastBuilder toastBuilder,
      UniqueKey key,
      String groupKey,
      bool allowClick = true,
      bool clickClose = false,
      bool ignoreContentClick = false,
      CancelFunc closeFunc,
      Color backgroundColor = Colors.transparent,
      WrapWidget warpWidget,
      Duration duration}) {
    CancelFunc cancelFunc = showWidget(
        groupKey: groupKey,
        key: key,
        toastBuilder: (cancel) {
          return KeyBoardSafeArea(
            child: GestureDetector(
              onTap: clickClose ? () => (closeFunc ?? cancel)() : null,
              behavior: allowClick
              ? HitTestBehavior.translucent
              : HitTestBehavior.opaque,
              child: SizedBox.expand(
            child: Builder(
              builder: (BuildContext context) {
                TextStyle textStyle = Theme.of(context).textTheme.body1;
                Widget child = DefaultTextStyle(
                    style: textStyle,
                    child: Stack(
                      children: <Widget>[
                        IgnorePointer(
                          child: Container(color: backgroundColor),
                        ),
                        SafeArea(
                            child: IgnorePointer(
                          ignoring: ignoreContentClick,
                          child: toastBuilder(cancel),
                        ))
                      ],
                    ));
                return warpWidget != null ? warpWidget(child) : child;
              },
            ),
              ),
            ),
          );
        });

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
