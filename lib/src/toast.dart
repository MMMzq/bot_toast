import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

part 'toast_widget.dart';

part 'bot_toast_manager.dart';

typedef CancelFunc = void Function();
typedef ToastBuilder = Widget Function(CancelFunc cancelFunc);

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
      Duration duration = const Duration(seconds: 2),
      bool clickClose = false,bool onlyOne=false}) {
    return showCustomText(
        duration: duration,
        clickClose: clickClose,
        onlyOne: onlyOne,
        textWidget: _TextToast(
          text: text,
        ));
  }

  ///[text] 需要显示的文本
  ///[duration] 持续时间
  ///[clickClose] 是否允许用户提前点击页面关闭Toast
  ///[CancelFunc] 关闭函数,主动调用将会关闭此Toast
  ///如果此方法的样式不符合,可以使用showWidget参照此方法定义一个
  static CancelFunc showCustomText(
      {@required Widget textWidget,
      Duration duration = const Duration(seconds: 2),
      bool clickClose = false,bool onlyOne = false}) {
    final key = GlobalKey<NormalAnimationState>();

    _safeRun(() {
      if (onlyOne) {
        cacheText
            .forEach((globalKey) => globalKey.currentState?.hide());
        cacheText.clear();
      }
      cacheText.add(key);
    });

    CancelFunc cancelAnimationFunc;

    //使用Scaffold主要是防止键盘挡住文本弹窗
    final cancelFunc = showWidget(
        toastBuilder: (cancelFunc) => NormalAnimation(
              key: key,
              disposeCallback: (){
                cacheNotification.remove(key);
              },
              child: IgnorePointer(
                  ignoring: !clickClose,
                  child: GestureDetector(
                    onTap: cancelAnimationFunc,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      body: textWidget,
                    ),
                  )),
            ),
        groupKey: textKey);

    //有动画的方式关闭
    cancelAnimationFunc = () async {
      await key.currentState?.hide();
      cancelFunc();
    };
    if (duration != null) {
      Future.delayed(duration, cancelAnimationFunc);
    }
    return cancelAnimationFunc;
  }

  ///[clickClose] 是否允许用户提前点击页面关闭Toast
  ///[allowClick] 使用允许用户可以点击页面,如果为true则用户可以正常触发事件,如果为false则用户的点击事件全都吸收掉
  ///[CancelFunc] 关闭函数,主动调用将会关闭此Toast
  ///如果此方法的样式不符合,可以使用showWidget参照此方法定义一个
  //todo 实现只显示一个加载动画,现在主要是动画衔接不上,太唐突,可以使用closeAllLoading代替着先
  static CancelFunc showLoading(
      {bool clickClose = false, bool allowClick = false}) {
    assert(!(clickClose && allowClick), "clickClose和allowClick不能同时为true!");
    final key = GlobalKey<_LoadingWidgetState>();

    //使用Scaffold主要是防止键盘挡住文本弹窗
    final cancelFunc = showWidget(
        toastBuilder: (cancelFunc) => IgnorePointer(
            ignoring: allowClick,
            child: GestureDetector(
              onTap: clickClose
                  ? () async {
                      await key.currentState?.hide();
                      cancelFunc();
                    }
                  : null,
              child: _LoadingWidget(
                key: key,
              ),
            )),
        groupKey: loadKey);
    return () async {
      await key.currentState?.hide();
      cancelFunc();
    };
  }

  ///此方法一般使用在dispose里面,防止因为开发人员没有主动去关闭,或者是请求api时的出现异常
  ///导致CancelFunc方法没有执行到等等,导致用户点击不了app
  static void closeAllLoading() {
    //以此方式移除将不会触发关闭动画
    removeAll(loadKey);
  }

  ///[widget] 需要显示的Widget
  ///[key] 代表此Toast的一个凭证,凭此key可以删除当前key所定义的Widget,[remove]
  ///[groupKey] 代表分组的key,主要用于[removeAll]和[remove]
  ///[CancelFunc] 关闭函数,主动调用将会关闭此Toast
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
