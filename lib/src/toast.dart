import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'basis.dart';
import 'bot_toast_init.dart';
import 'keyboard_safe_area.dart';
import 'keyboard_visibility.dart';
import 'toast_navigator_observer.dart';
import 'toast_widget/toast_widget.dart';

/*区域图
  _________________________________
|          MainContent            |
|                                 |
|                                 |
|      ___________________        |
|     |                   |       |
|     |    ToastContent   |       |
|     |___________________|       |
|_________________________________|
 */

///[ToastBuilder]方法生成widget时,请确保生成的Widget背景不会吸收点击事件
///例如[Scaffold],[Material]都会默认占满整个父空间,
///并且会吸收事件(就算透明也是这种情况),具体例子可看[material.dart->_RenderInkFeatures class->hitTestSelf method]
///如果真的要生成,可以考虑使用[IgnorePointer].
///如果没有遵守规则,将会时某些功能失效例如[allowClick]功能就会失效
class BotToast {
  static const String textKey = '_textKey';
  static const String notificationKey = '_notificationKey';
  static const String loadKey = '_loadKey';
  static const String attachedKey = '_attachedKey';
  static const String defaultKey = '_defaultKey';

  static final Map<String, List<CancelFunc>> cacheCancelFunc = {
    textKey: [],
    notificationKey: [],
    loadKey: [],
    attachedKey: [],
    defaultKey: [],
  };

  ///显示简单的通知Toast
  ///
  ///[title] 标题
  ///[subTitle] 副标题
  ///[closeIcon] 关闭按钮的图标
  ///[enableSlideOff] 是否能滑动删除
  ///[hideCloseButton] 是否隐藏关闭按钮
  ///[align] ToastContent区域在MainContent区域的对齐
  ///[dismissDirections] 能进行滑动关闭的方向
  ///[onTap] 点击通知Toast的回调
  ///[onLongPress] 长按通知Toast的回调
  ///[wrapAnimation] 请看[showAnimationWidget.wrapAnimation],默认值为null
  ///[wrapToastAnimation] 请看[showAnimationWidget.wrapToastAnimation],默认值为[notificationAnimation]
  ///[animationDuration] 请看[showAnimationWidget.animationDuration]
  ///[animationReverseDuration] 请看[showAnimationWidget.animationReverseDuration]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[onlyOne] 请看[showEnhancedWidget.onlyOne]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  ///[backButtonBehavior] 请看[showEnhancedWidget.backButtonBehavior]
  ///[backgroundColor] defaults to Theme.of(context).cardColor
  ///[borderRadius] defaults to ThemeData.cardTheme.shape
  ///[enableKeyboardSafeArea] 请看[showEnhancedWidget.enableKeyboardSafeArea]
  static CancelFunc showSimpleNotification(
      {required String title,
      String? subTitle,
      TextStyle? titleStyle,
      TextStyle? subTitleStyle,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = notificationAnimation,
      GestureTapCallback? onTap,
      GestureLongPressCallback? onLongPress,
      Color? backgroundColor,
      double? borderRadius,
      Alignment? align = const Alignment(0, -0.99),
      List<DismissDirection> dismissDirections = const [
        DismissDirection.horizontal,
        DismissDirection.up
      ],
      Icon? closeIcon,
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      BackButtonBehavior? backButtonBehavior,
      VoidCallback? onClose,
      bool enableKeyboardSafeArea = true,
      bool enableSlideOff = true,
      bool hideCloseButton = false,
      bool crossPage = true,
      bool onlyOne = true}) {
    return showNotification(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        align: align,
        dismissDirections: dismissDirections,
        duration: duration,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        backgroundColor: backgroundColor,
        borderRadius: borderRadius,
        animationDuration: animationDuration,
        backButtonBehavior: backButtonBehavior,
        animationReverseDuration: animationReverseDuration,
        enableSlideOff: enableSlideOff,
        onTap: onTap,
        onLongPress: onLongPress,
        onClose: onClose,
        onlyOne: onlyOne,
        crossPage: crossPage,
        title: (_) => Text(title, style: titleStyle),
        subtitle: subTitle == null
            ? null
            : (_) => Text(subTitle, style: subTitleStyle),
        trailing: hideCloseButton
            ? null
            : (cancel) => IconButton(
                icon: closeIcon ?? const Icon(Icons.cancel),
                onPressed: cancel));
  }

  ///显示一个标准的通知Toast
  ///
  ///[leading]_[title]_[subtitle]_[trailing]_[contentPadding] 请看[ListTile]
  ///[enableSlideOff] 是否能滑动删除
  ///[align] ToastContent区域在MainContent区域的对齐
  ///[dismissDirections] 能进行滑动关闭的方向
  ///[onTap] 点击通知Toast的回调
  ///[onLongPress] 长按通知Toast的回调
  ///[wrapAnimation] 请看[showAnimationWidget.wrapAnimation],默认值为null
  ///[wrapToastAnimation] 请看[showAnimationWidget.wrapToastAnimation],默认值为[notificationAnimation]
  ///[animationDuration] 请看[showAnimationWidget.animationDuration]
  ///[animationReverseDuration] 请看[showAnimationWidget.animationReverseDuration]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[onlyOne] 请看[showEnhancedWidget.onlyOne]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  ///[backButtonBehavior] 请看[showEnhancedWidget.backButtonBehavior]
  ///[backgroundColor] defaults to Theme.of(context).cardColor
  ///[borderRadius] defaults to ThemeData.cardTheme.shape
  ///[enableKeyboardSafeArea] 请看[showEnhancedWidget.enableKeyboardSafeArea]
  static CancelFunc showNotification(
      {ToastBuilder? leading,
      ToastBuilder? title,
      ToastBuilder? subtitle,
      ToastBuilder? trailing,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = notificationAnimation,
      GestureTapCallback? onTap,
      Color? backgroundColor,
      double? borderRadius,
      GestureLongPressCallback? onLongPress,
      Alignment? align = const Alignment(0, -0.99),
      List<DismissDirection> dismissDirections = const [
        DismissDirection.horizontal,
        DismissDirection.up
      ],
      BackButtonBehavior? backButtonBehavior,
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      EdgeInsetsGeometry? contentPadding,
      VoidCallback? onClose,
      bool enableKeyboardSafeArea = true,
      bool enableSlideOff = true,
      bool crossPage = true,
      bool onlyOne = true}) {
    return showCustomNotification(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        align: align,
        dismissDirections: dismissDirections,
        enableSlideOff: enableSlideOff,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onlyOne: onlyOne,
        backButtonBehavior: backButtonBehavior,
        crossPage: crossPage,
        onClose: onClose,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        toastBuilder: (cancel) {
          return Card(
            color: backgroundColor,
            shape: borderRadius == null
                ? null
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
            child: ListTile(
                onTap: onTap,
                onLongPress: onLongPress,
                contentPadding: contentPadding,
                leading: leading?.call(cancel),
                title: title?.call(cancel),
                subtitle: subtitle?.call(cancel),
                trailing: trailing?.call(cancel)),
          );
        });
  }

  ///显示一个自定义的通知Toast
  ///
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///[enableSlideOff] 是否能滑动删除
  ///[align] ToastContent区域在MainContent区域的对齐
  ///[dismissDirections] 能进行滑动关闭的方向
  ///[wrapAnimation] 请看[showAnimationWidget.wrapAnimation],默认值为null
  ///[wrapToastAnimation] 请看[showAnimationWidget.wrapToastAnimation],默认值为[notificationAnimation]
  ///[animationDuration] 请看[showAnimationWidget.animationDuration]
  ///[animationReverseDuration] 请看[showAnimationWidget.animationReverseDuration]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[onlyOne] 请看[showEnhancedWidget.onlyOne]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  ///[backButtonBehavior] 请看[showEnhancedWidget.backButtonBehavior]
  ///[enableKeyboardSafeArea] 请看[showEnhancedWidget.enableKeyboardSafeArea]
  static CancelFunc showCustomNotification(
      {required ToastBuilder toastBuilder,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = notificationAnimation,
      Alignment? align = const Alignment(0, -0.99),
      List<DismissDirection> dismissDirections = const [
        DismissDirection.horizontal,
        DismissDirection.up
      ],
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      VoidCallback? onClose,
      BackButtonBehavior? backButtonBehavior,
      bool enableKeyboardSafeArea = true,
      bool enableSlideOff = true,
      bool crossPage = true,
      bool onlyOne = true}) {
    return showAnimationWidget(
        crossPage: crossPage,
        allowClick: true,
        clickClose: false,
        ignoreContentClick: false,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onlyOne: onlyOne,
        onClose: onClose,
        duration: duration,
        backButtonBehavior: backButtonBehavior,
        animationDuration:
            animationDuration ?? const Duration(milliseconds: 256),
        animationReverseDuration: animationReverseDuration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) {
          if (wrapToastAnimation != null) {
            child = wrapToastAnimation(controller, cancel, child);
          }
          if (align != null) {
            child = Align(alignment: align, child: child);
          }
          return SafeArea(child: child);
        },
        toastBuilder: (cancelFunc) => NotificationToast(
            child: toastBuilder(cancelFunc),
            dismissDirections: dismissDirections,
            slideOffFunc: enableSlideOff ? cancelFunc : null),
        groupKey: notificationKey);
  }

  ///显示一个标准文本Toast
  ///
  ///[text] 需要显示的文本
  ///[contentColor] ToastContent区域背景颜色
  ///[borderRadius] ToastContent区域圆角
  ///[textStyle] 字体样式
  ///[contentPadding] ToastContent区域的内补
  ///[align] ToastContent区域在MainContent区域的对齐
  ///[wrapAnimation] 请看[showAnimationWidget.wrapAnimation],默认值为null
  ///[wrapToastAnimation] 请看[showAnimationWidget.wrapToastAnimation],默认值为[textAnimation]
  ///[animationDuration] 请看[showAnimationWidget.animationDuration]
  ///[animationReverseDuration] 请看[showAnimationWidget.animationReverseDuration]
  ///[backgroundColor] 请看[showEnhancedWidget.backgroundColor]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[onlyOne] 请看[showEnhancedWidget.onlyOne]
  ///[clickClose] 请看[showEnhancedWidget.clickClose]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  ///[backButtonBehavior] 请看[showEnhancedWidget.backButtonBehavior]
  ///[enableKeyboardSafeArea] 请看[showEnhancedWidget.enableKeyboardSafeArea]
  static CancelFunc showText(
      {required String text,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = textAnimation,
      Color backgroundColor = Colors.transparent,
      Color contentColor = Colors.black54,
      BorderRadiusGeometry borderRadius =
          const BorderRadius.all(Radius.circular(8)),
      TextStyle textStyle = const TextStyle(fontSize: 17, color: Colors.white),
      AlignmentGeometry? align = const Alignment(0, 0.8),
      EdgeInsetsGeometry contentPadding =
          const EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7),
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      BackButtonBehavior? backButtonBehavior,
      VoidCallback? onClose,
      bool enableKeyboardSafeArea = true,
      bool clickClose = false,
      bool crossPage = true,
      bool onlyOne = true}) {
    return showCustomText(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        crossPage: crossPage,
        backgroundColor: backgroundColor,
        clickClose: clickClose,
        backButtonBehavior: backButtonBehavior,
        onClose: onClose,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        ignoreContentClick: true,
        onlyOne: onlyOne,
        align: align,
        toastBuilder: (_) => TextToast(
              contentPadding: contentPadding,
              contentColor: contentColor,
              borderRadius: borderRadius,
              textStyle: textStyle,
              text: text,
            ));
  }

  ///显示一个自定义的文本Toast
  ///
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///[align] ToastContent区域在MainContent区域的对齐
  ///[wrapAnimation] 请看[showAnimationWidget.wrapAnimation],默认值为null
  ///[wrapToastAnimation] 请看[showAnimationWidget.wrapToastAnimation],默认值为[textAnimation]
  ///[animationDuration] 请看[showAnimationWidget.animationDuration]
  ///[animationReverseDuration] 请看[showAnimationWidget.animationReverseDuration]
  ///[ignoreContentClick] 请看[showEnhancedWidget.ignoreContentClick]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[onlyOne] 请看[showEnhancedWidget.onlyOne]
  ///[clickClose] 请看[showEnhancedWidget.clickClose]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[backgroundColor] 请看[showEnhancedWidget.backgroundColor]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  ///[backButtonBehavior] 请看[showEnhancedWidget.backButtonBehavior]
  ///[enableKeyboardSafeArea] 请看[showEnhancedWidget.enableKeyboardSafeArea]
  static CancelFunc showCustomText(
      {required ToastBuilder toastBuilder,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = textAnimation,
      AlignmentGeometry? align = const Alignment(0, 0.8),
      Color backgroundColor = Colors.transparent,
      Duration? duration = const Duration(seconds: 2),
      Duration? animationDuration,
      Duration? animationReverseDuration,
      VoidCallback? onClose,
      BackButtonBehavior? backButtonBehavior,
      bool enableKeyboardSafeArea = true,
      bool crossPage = true,
      bool clickClose = false,
      bool ignoreContentClick = false,
      bool onlyOne = false}) {
    return showAnimationWidget(
        groupKey: textKey,
        clickClose: clickClose,
        allowClick: true,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        onlyOne: onlyOne,
        crossPage: crossPage,
        ignoreContentClick: ignoreContentClick,
        backgroundColor: backgroundColor,
        backButtonBehavior: backButtonBehavior,
        onClose: onClose,
        duration: duration,
        animationDuration:
            animationDuration ?? const Duration(milliseconds: 256),
        animationReverseDuration: animationReverseDuration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) {
          if (wrapToastAnimation != null) {
            child = wrapToastAnimation(controller, cancel, child);
          }
          if (align != null) {
            child = Align(alignment: align, child: child);
          }
          return SafeArea(child: child);
        },
        toastBuilder: toastBuilder);
  }

  ///显示一个标准的加载Toast
  ///
  ///[align] ToastContent区域在MainContent区域的对齐
  ///[wrapAnimation] 请看[showAnimationWidget.wrapAnimation],默认值为[loadingAnimation]
  ///[wrapToastAnimation] 请看[showAnimationWidget.wrapToastAnimation],默认值为null
  ///[animationDuration] 请看[showAnimationWidget.animationDuration]
  ///[animationReverseDuration] 请看[showAnimationWidget.animationReverseDuration]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[allowClick] 请看[showEnhancedWidget.allowClick]
  ///[clickClose] 请看[showEnhancedWidget.clickClose]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[backgroundColor] 请看[showEnhancedWidget.backgroundColor]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  ///[backButtonBehavior] 请看[showEnhancedWidget.backButtonBehavior]
  ///[enableKeyboardSafeArea] 请看[showEnhancedWidget.enableKeyboardSafeArea]
  static CancelFunc showLoading({
    WrapAnimation? wrapAnimation = loadingAnimation,
    WrapAnimation? wrapToastAnimation,
    Alignment align = Alignment.center,
    BackButtonBehavior? backButtonBehavior,
    bool crossPage = true,
    bool clickClose = false,
    bool allowClick = false,
    bool enableKeyboardSafeArea = true,
    VoidCallback? onClose,
    Duration? duration,
    Duration? animationDuration,
    Duration? animationReverseDuration,
    Color backgroundColor = Colors.black26,
  }) {
    return showCustomLoading(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        align: align,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        backButtonBehavior: backButtonBehavior,
        toastBuilder: (_) => const LoadingWidget(),
        clickClose: clickClose,
        allowClick: allowClick,
        crossPage: crossPage,
        ignoreContentClick: true,
        onClose: onClose,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        backgroundColor: backgroundColor);
  }

  ///显示一个自定义的加载Toast
  ///
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///[align] ToastContent区域在MainContent区域的对齐
  ///[wrapAnimation] 请看[showAnimationWidget.wrapAnimation],默认值为[loadingAnimation]
  ///[wrapToastAnimation] 请看[showAnimationWidget.wrapToastAnimation],默认值为null
  ///[animationDuration] 请看[showAnimationWidget.animationDuration]
  ///[animationReverseDuration] 请看[showAnimationWidget.animationReverseDuration]
  ///[ignoreContentClick] 请看[showEnhancedWidget.ignoreContentClick]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[allowClick] 请看[showEnhancedWidget.allowClick]
  ///[clickClose] 请看[showEnhancedWidget.clickClose]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[backgroundColor] 请看[showEnhancedWidget.backgroundColor]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  ///[backButtonBehavior] 请看[showEnhancedWidget.backButtonBehavior]
  ///[enableKeyboardSafeArea] 请看[showEnhancedWidget.enableKeyboardSafeArea]
  static CancelFunc showCustomLoading({
    required ToastBuilder toastBuilder,
    WrapAnimation? wrapAnimation = loadingAnimation,
    WrapAnimation? wrapToastAnimation,
    Alignment? align = Alignment.center,
    BackButtonBehavior? backButtonBehavior,
    bool clickClose = false,
    bool allowClick = false,
    bool ignoreContentClick = false,
    bool crossPage = false,
    bool enableKeyboardSafeArea = true,
    VoidCallback? onClose,
    Duration? duration,
    Duration? animationDuration,
    Duration? animationReverseDuration,
    Color backgroundColor = Colors.black26,
  }) {
    return showAnimationWidget(
        groupKey: loadKey,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        toastBuilder: toastBuilder,
        backButtonBehavior: backButtonBehavior,
        animationDuration:
            animationDuration ?? const Duration(milliseconds: 300),
        animationReverseDuration: animationReverseDuration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) {
          if (wrapToastAnimation != null) {
            child = wrapToastAnimation(controller, cancel, child);
          }
          if (align != null) {
            child = Align(alignment: align, child: child);
          }
          return SafeArea(child: child);
        },
        onClose: onClose,
        clickClose: clickClose,
        allowClick: allowClick,
        crossPage: crossPage,
        ignoreContentClick: ignoreContentClick,
        onlyOne: false,
        duration: duration,
        backgroundColor: backgroundColor);
  }

  ///此方法一般使用在dispose里面,防止因为开发人员没有主动去关闭,或者是请求api时的出现异常
  ///导致CancelFunc方法没有执行到等等,导致用户点击不了app
  static void closeAllLoading() {
    //以此方式移除将不会触发关闭动画
    removeAll(loadKey);
  }

  ///显示一个定位Toast
  ///该方法可以在某个Widget(一般是Button)或者给定一个offset周围显示
  ///
  ///[attachedBuilder] 生成需要显示的Widget的builder函数
  ///[targetContext] 目标Widget(一般是一个按钮),使用上一般会使用[Builder]包裹,来获取到BuildContext
  ///[target] 目标[Offset],该偏移是以屏幕左上角为原点来计算的
  ///[target]和[targetContext] 只能二选一
  ///[verticalOffset]  垂直偏移跟[preferDirection]有关,根据不同的方向会作用在不用的方向上
  ///[horizontalOffset]  水平偏移跟[preferDirection]有关,根据不同的方向会作用在不用的方向上
  ///[preferDirection] 偏好方向,如果在空间允许的情况下,会偏向显示在那边
  ///[enableSafeArea] 如果为true则toast确保不会显示在app状态栏上面(意味着是安全的),false则反之
  ///[wrapAnimation] 请看[showAnimationWidget.wrapAnimation],默认值为null
  ///[wrapToastAnimation] 请看[showAnimationWidget.wrapToastAnimation],默认值为[attachedAnimation]
  ///[animationDuration] 请看[showAnimationWidget.animationDuration]
  ///[animationReverseDuration] 请看[showAnimationWidget.animationReverseDuration]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[ignoreContentClick] 请看[showEnhancedWidget.ignoreContentClick]
  ///[onlyOne] 请看[showEnhancedWidget.onlyOne]
  ///[allowClick] 请看[showEnhancedWidget.allowClick]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  ///[enableKeyboardSafeArea] 请看[showEnhancedWidget.enableKeyboardSafeArea]
  static CancelFunc showAttachedWidget(
      {required ToastBuilder attachedBuilder,
      WrapAnimation? wrapAnimation,
      WrapAnimation? wrapToastAnimation = attachedAnimation,
      BuildContext? targetContext,
      Offset? target,
      Color backgroundColor = Colors.transparent,
      double verticalOffset = 0.0,
      double horizontalOffset = 0.0,
      Duration? duration,
      Duration? animationDuration,
      Duration? animationReverseDuration,
      PreferDirection? preferDirection,
      VoidCallback? onClose,
      bool ignoreContentClick = false,
      bool onlyOne = false,
      bool allowClick = true,
      bool enableKeyboardSafeArea = true,
      bool enableSafeArea = true}) {
    assert(verticalOffset >= 0.0, 'must be a positive number');
    assert(horizontalOffset >= 0.0, 'must be a positive number');
    assert(!(targetContext != null && target != null),
        'targetContext and target cannot coexist');
    assert(targetContext != null || target != null,
        'targetContext and target must exist one');

    Rect targetRect;
    if (target == null) {
      RenderObject renderObject = targetContext!.findRenderObject()!;
      if (renderObject is RenderBox) {
        final position = renderObject.localToGlobal(Offset.zero);
        targetRect = Rect.fromLTWH(position.dx, position.dy,
            renderObject.size.width, renderObject.size.height);
      } else {
        throw Exception(
            'context.findRenderObject() return result must be RenderBox class');
      }
    } else {
      targetRect = Rect.fromLTWH(target.dx, target.dy, 0, 0); //点矩形
    }
    return showAnimationWidget(
        allowClick: allowClick,
        clickClose: true,
        groupKey: attachedKey,
        crossPage: false,
        onlyOne: onlyOne,
        onClose: onClose,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        backgroundColor: backgroundColor,
        ignoreContentClick: ignoreContentClick,
        animationDuration:
            animationDuration ?? const Duration(milliseconds: 150),
        animationReverseDuration: animationReverseDuration,
        duration: duration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) => KeyboardVisibility(
              onKeyboardVisibilityChanged: (open) {
                if (open) {
                  cancel();
                }
              },
              child: CustomSingleChildLayout(
                  delegate: PositionDelegate(
                      target: targetRect,
                      verticalOffset: verticalOffset,
                      horizontalOffset: horizontalOffset,
                      enableSafeArea: enableSafeArea,
                      preferDirection: preferDirection),
                  child: wrapToastAnimation != null
                      ? wrapToastAnimation(controller, cancel, child)
                      : child),
            ),
        toastBuilder: attachedBuilder);
  }

  ///显示使用了Animation的Toast
  ///使用请看:
  ///[BotToast.showCustomNotification]
  ///[BotToast.showCustomText]
  ///[BotToast.showCustomLoading]
  ///[BotToast.showAttachedWidget]
  ///
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///[animationDuration] 正向动画的持续时间,其含义等同于[AnimationController.duration],值得注意的是建议不要超过[duration]
  ///[animationReverseDuration] 反向动画的持续时间,其含义等同于[AnimationController.reverseDuration]
  ///
  ///[wrapAnimation] 包装MainContent区域的动画,可用于自定义动画,如果为null则表示不需要动画,
  ///使用这个函数不意味着一定要使用动画,可以额外做一些包装widget的处理
  ///
  ///[wrapToastAnimation] 包装ToastContent区域的动画,可用于自定义动画,如果为null则表示不需要动画,
  ///使用这个函数不意味着一定要使用动画,可以额外做一些包装widget的处理
  ///
  ///[key] 请看[showEnhancedWidget.key]
  ///[groupKey] 请看[showEnhancedWidget.groupKey]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[allowClick] 请看[showEnhancedWidget.allowClick]
  ///[clickClose] 请看[showEnhancedWidget.clickClose]
  ///[ignoreContentClick] 请看[showEnhancedWidget.ignoreContentClick]
  ///[onlyOne] 请看[showEnhancedWidget.onlyOne]
  ///[backgroundColor] 请看[showEnhancedWidget.backgroundColor]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  ///[backButtonBehavior] 请看[showEnhancedWidget.backButtonBehavior]
  ///[enableKeyboardSafeArea] 请看[showEnhancedWidget.enableKeyboardSafeArea]
  static CancelFunc showAnimationWidget({
    required ToastBuilder toastBuilder,
    required Duration animationDuration,
    Duration? animationReverseDuration,
    WrapAnimation? wrapAnimation,
    WrapAnimation? wrapToastAnimation,
    BackButtonBehavior? backButtonBehavior,
    UniqueKey? key,
    String? groupKey,
    bool crossPage = true,
    bool allowClick = true,
    bool clickClose = false,
    bool ignoreContentClick = false,
    bool onlyOne = false,
    bool enableKeyboardSafeArea = true,
    Color backgroundColor = Colors.transparent,
    Duration? duration,
    VoidCallback? onClose,
  }) {
    AnimationController? controller = _createAnimationController(
        animationDuration,
        reverseDuration: animationReverseDuration);

    return showEnhancedWidget(
        allowClick: allowClick,
        clickClose: clickClose,
        groupKey: groupKey,
        key: key,
        crossPage: crossPage,
        onClose: onClose,
        onlyOne: onlyOne,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        backButtonBehavior: backButtonBehavior,
        backgroundColor: backgroundColor,
        ignoreContentClick: ignoreContentClick,
        closeFunc: () async {
          await controller?.reverse();
        },
        duration: duration,
        warpWidget: (cancel, child) => ProxyInitState(
              initStateCallback: () {
                assert(!controller!.isAnimating);
                controller!.forward();
              },
              child: ProxyDispose(
                  disposeCallback: () {
                    controller!.dispose();
                    controller = null;
                  },
                  child: wrapAnimation != null
                      ? wrapAnimation(controller!, cancel, child)
                      : child),
            ),
        toastBuilder: (cancelFunc) => wrapToastAnimation != null
            ? wrapToastAnimation(
                controller!, cancelFunc, toastBuilder(cancelFunc))
            : toastBuilder(cancelFunc));
  }

  /*区域图
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

  ///显示一个增强Toast,该方法可以让Toast自带很多特性,例如定时关闭,点击屏幕自动关闭,离开当前Route关闭等等
  ///核心方法,详情使用请看:
  ///[BotToast.showAnimationWidget]
  ///
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///
  ///[key] 代表此Toast的一个凭证,凭此key可以删除当前key所定义的Widget,[remove]
  ///
  ///[groupKey] 代表分组的key,主要用于[removeAll]和[remove]
  ///
  ///[crossPage] 跨页面显示,如果为true,则该Toast会跨越多个Route显示,
  ///如果为false则在当前Route发生变化时,会自动关闭该Toast,例如[Navigator.push]-[Navigator.pop]
  ///
  ///[allowClick] 是否在该Toast显示时,能否正常点击触发事件
  ///
  ///[clickClose] 是否在点击屏幕触发事件时自动关闭该Toast
  ///
  ///[ignoreContentClick] 是否忽视ToastContext区域
  ///这个参数如果为true时,用户点击该ToastContext区域时,用户可以的点击事件可以正常到达到Page上
  ///换一句话说就是透明的(即便是Toast背景颜色不是透明),如果为false,则情况反之
  ///
  ///[onlyOne] 表示是否该分组内是否在同一时间里只存在一个Toast,区分是哪一个组是按照[groupKey]来区分的
  ///
  ///[closeFunc] 该函数参数主要目的使Toast关闭之做一些处理例如
  ///触发关闭前调用[AnimationController]来启动并等待动画后再关闭
  ///
  ///[backgroundColor]  MainContent区域的背景颜色
  ///
  ///[warpWidget] 一个wrap函数,可以用来warp MainContent区域,例如[showCustomLoading]就包裹了一个动画
  ///让MainContent区域也具有动画
  ///
  ///[duration] 持续时间,如果为null则不会去定时关闭,如果不为null则在到达指定时间时自动关闭
  ///
  ///[onClose] Toast关闭时调用
  ///
  ///[enableKeyboardSafeArea] 是否启用键盘安全区,防止键盘挡住Toast
  ///
  ///[backButtonBehavior] 点击物理返回键的行为(在android上等同于物理的返回键),注意不是导航条上的返回按钮
  ///如果为[ignore]则拦截返回事件,
  ///如果为[close]则关闭该toast,并且拦截事件停止冒泡
  ///如果为null or [none]则不拦截事件
  ///
  static CancelFunc showEnhancedWidget(
      {required ToastBuilder toastBuilder,
      UniqueKey? key,
      String? groupKey,
      bool crossPage = true,
      bool allowClick = true,
      bool clickClose = false,
      bool ignoreContentClick = false,
      bool onlyOne = false,
      bool enableKeyboardSafeArea = true,
      BackButtonBehavior? backButtonBehavior,
      FutureFunc? closeFunc,
      VoidCallback? onClose,
      Color backgroundColor = Colors.transparent,
      WrapWidget? warpWidget,
      Duration? duration}) {
    // ignore: unnecessary_null_comparison
    assert(enableKeyboardSafeArea != null);

    //由于cancelFunc一开始是为空的,所以在赋值之前需要在闭包里使用
    late final CancelFunc cancelFunc;
    final CancelFunc dismissFunc = () async {
      await closeFunc?.call();
      cancelFunc();
    };

    //onlyOne 功能
    final List<CancelFunc> cache =
        (cacheCancelFunc[groupKey ?? defaultKey] ??= []);
    if (onlyOne) {
      final clone = cache.toList();
      cache.clear();
      clone.forEach((cancel) {
        cancel();
      });
    }
    cache.add(dismissFunc);

    //定时功能
    Timer? timer;
    if (duration != null) {
      timer = Timer(duration, () {
        dismissFunc();
        timer = null;
      });
    }

    //跨页自动关闭
    BotToastNavigatorObserverProxy? observerProxy;
    if (!crossPage) {
      observerProxy = BotToastNavigatorObserverProxy.all(dismissFunc);
      BotToastNavigatorObserver.register(observerProxy);
    }

    //拦截点击返回事件
    VoidCallback? unRegisterFunc;
    if (backButtonBehavior == BackButtonBehavior.ignore) {
      unRegisterFunc =
          BotToastWidgetsBindingObserver.singleton.registerPopListener(() {
        return true;
      });
    } else if (backButtonBehavior == BackButtonBehavior.close) {
      unRegisterFunc =
          BotToastWidgetsBindingObserver.singleton.registerPopListener(() {
        dismissFunc();
        unRegisterFunc?.call();
        unRegisterFunc = null;
        return true;
      });
    }

    cancelFunc = showWidget(
        groupKey: groupKey,
        key: key,
        toastBuilder: (_) {
          return KeyboardSafeArea(
            enable: enableKeyboardSafeArea,
            child: ProxyDispose(disposeCallback: () {
              cache.remove(dismissFunc);
              if (observerProxy != null) {
                BotToastNavigatorObserver.unregister(observerProxy);
              }
              timer?.cancel();
              onClose?.call();
              unRegisterFunc?.call();
            }, child: Builder(builder: (BuildContext context) {
              final TextStyle textStyle =
                  Theme.of(context).textTheme.bodyText2!;
              Widget child = DefaultTextStyle(
                  style: textStyle,
                  child: Stack(children: <Widget>[
                    Listener(
                      onPointerDown: clickClose ? (_) => dismissFunc() : null,
                      behavior: allowClick
                          ? HitTestBehavior.translucent
                          : HitTestBehavior.opaque,
                      child: const SizedBox.expand(),
                    ),
                    IgnorePointer(
                      child: Container(color: backgroundColor),
                    ),
                    IgnorePointer(
                      ignoring: ignoreContentClick,
                      child: toastBuilder(dismissFunc),
                    )
                  ]));
              return warpWidget != null
                  ? warpWidget(dismissFunc, child)
                  : child;
            })),
          );
        });

    return dismissFunc;
  }

  ///显示一个Widget在屏幕上,该Widget可以跨多个页面存在
  ///
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///[key] 代表此Toast的一个凭证,凭此key可以删除当前key所定义的Widget,[remove]
  ///[groupKey] 代表分组的key,主要用于[removeAll]和[remove]
  ///[CancelFunc] 关闭函数,主动调用将会关闭此Toast
  ///这是个核心方法
  static CancelFunc showWidget(
      {required ToastBuilder toastBuilder, UniqueKey? key, String? groupKey}) {
    final gk = groupKey ?? defaultKey;
    final uniqueKey = key ?? UniqueKey();
    final CancelFunc cancelFunc = () {
      remove(uniqueKey, gk);
    };

    botToastManager.insert(gk, uniqueKey, toastBuilder(cancelFunc));
    return cancelFunc;
  }

  static void remove(UniqueKey key, [String? groupKey]) {
    botToastManager.remove(groupKey ?? defaultKey, key);
  }

  static void removeAll([String? groupKey]) {
    botToastManager.removeAll(groupKey ?? defaultKey);
  }

  static void cleanAll() {
    botToastManager.cleanAll();
  }

  static AnimationController _createAnimationController(Duration duration,
      {Duration? reverseDuration}) {
    return AnimationController(
        vsync: TickerProviderImpl(),
        duration: duration,
        reverseDuration: reverseDuration);
  }
}
