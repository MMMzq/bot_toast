import 'dart:async';

import 'package:flutter/material.dart';

import 'basis.dart';
import 'bot_toast_init.dart';
import 'keyboard_safe_area.dart';
import 'keyboard_visibility.dart';
import 'nil.dart';
import 'option.dart';
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

/// When generating widgets using the [ToastBuilder] method, please ensure that the generated widget's background does not absorb click events.
/// For example, [Scaffold] and [Material] widgets will by default occupy the entire parent space and absorb events (even if they are transparent). You can refer to the [material.dart -> _RenderInkFeatures class -> hitTestSelf method] for specific examples.
/// If you must generate such widgets, consider using [IgnorePointer].
/// Failure to follow this rule may result in the malfunction of certain features, such as the [allowClick] feature.
///
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

  /// Global default options
  /// Once these default options are modified, they will take effect globally.
  /// [Option.simpleNotification] corresponds to the default value of [showSimpleNotification]
  /// [Option.notification] corresponds to the default value of [showNotification]
  /// [Option.customNotification] corresponds to the default value of [showCustomNotification]
  /// [Option.text] corresponds to the default value of [showText]
  /// [Option.customText] corresponds to the default value of [showCustomText]
  /// [Option.loading] corresponds to the default value of [showLoading]
  /// [Option.customLoading] corresponds to the default value of [showCustomLoading]
  /// [Option.attached] corresponds to the default value of [showAttachedWidget]
  /// [Option.animation] corresponds to the default value of [showAnimationWidget]
  /// [Option.enhanced] corresponds to the default value of [showEnhancedWidget]
  ///
  ///全局默认选项
  ///一旦修改了该默认选项将会在在全局范围内生效
  ///[Option.simpleNotification] 对应 [showSimpleNotification] 的默认值
  ///[Option.notification] 对应 [showNotification] 的默认值
  ///[Option.customNotification] 对应 [showCustomNotification] 的默认值
  ///[Option.text] 对应 [showText] 的默认值
  ///[Option.customText] 对应 [showCustomText] 的默认值
  ///[Option.loading] 对应 [showLoading] 的默认值
  ///[Option.customLoading] 对应 [showCustomLoading] 的默认值
  ///[Option.attached] 对应 [showAttachedWidget] 的默认值
  ///[Option.animation] 对应 [showAnimationWidget] 的默认值
  ///[Option.enhanced] 对应 [showEnhancedWidget] 的默认值
  static final Option defaultOption = Option();

  /// Display a simple notification Toast.
  /// [title] - Title.
  /// [subTitle] - Subtitle.
  /// [closeIcon] - Icon for the close button.
  /// [enableSlideOff] - Whether sliding to dismiss is enabled.
  /// [hideCloseButton] - Whether to hide the close button.
  /// [align] - Alignment of the ToastContent area within the MainContent area.
  /// [dismissDirections] - Directions in which sliding to dismiss is allowed.
  /// [onTap] - Callback when the notification Toast is tapped.
  /// [onLongPress] - Callback when the notification Toast is long-pressed.
  /// [wrapAnimation] - See [showAnimationWidget.wrapAnimation], default value is null.
  /// [wrapToastAnimation] - See [showAnimationWidget.wrapToastAnimation], default value is [notificationAnimation].
  /// [animationDuration] - See [showAnimationWidget.animationDuration].
  /// [animationReverseDuration] - See [showAnimationWidget.animationReverseDuration].
  /// [duration] - See [showEnhancedWidget.duration].
  /// [crossPage] - See [showEnhancedWidget.crossPage].
  /// [onlyOne] - See [showEnhancedWidget.onlyOne].
  /// [onClose] - See [showEnhancedWidget.onClose].
  /// [backButtonBehavior] - See [showEnhancedWidget.backButtonBehavior].
  /// [backgroundColor] - Defaults to Theme.of(context).cardColor.
  /// [borderRadius] - Defaults to ThemeData.cardTheme.shape.
  /// [enableKeyboardSafeArea] - See [showEnhancedWidget.enableKeyboardSafeArea].
  ///
  ///显示简单的通知Toast
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
      /*String*/ Object? subTitle = nil,
      TextStyle? titleStyle = nilTextStyle,
      TextStyle? subTitleStyle = nilTextStyle,
      WrapAnimation? wrapAnimation = nilWrapAnimation,
      WrapAnimation? wrapToastAnimation = nilWrapAnimation,
      GestureTapCallback? onTap = nilVoidCallback,
      GestureLongPressCallback? onLongPress = nilVoidCallback,
      Color? backgroundColor = nilColor,
      /*double*/ Object? borderRadius = nilBackButtonBehavior,
      Alignment? align = nilAlignment,
      List<DismissDirection> dismissDirections = nilDismissDirectionList,
      Icon? closeIcon = nilIcon,
      Duration? duration = nilDuration,
      Duration? animationDuration = nilDuration,
      Duration? animationReverseDuration = nilDuration,
      BackButtonBehavior? backButtonBehavior = nilBackButtonBehavior,
      VoidCallback? onClose = nilVoidCallback,
      /*bool*/ Object enableKeyboardSafeArea = nil,
      /*bool*/ Object enableSlideOff = nil,
      /*bool*/ Object hideCloseButton = nil,
      /*bool*/ Object crossPage = nil,
      /*bool*/ Object onlyOne = nil}) {
    var o = defaultOption.simpleNotification;

    wrapAnimation = returnFirstIfNotNil(wrapAnimation, o.wrapAnimation);
    wrapToastAnimation = returnFirstIfNotNil(wrapToastAnimation, o.wrapToastAnimation);
    align = returnFirstIfNotNil(align, o.align);
    dismissDirections = returnFirstIfNotNil(dismissDirections, o.dismissDirections);
    duration = returnFirstIfNotNil(duration, o.duration);
    enableKeyboardSafeArea = returnFirstIfNotNil(enableKeyboardSafeArea, o.enableKeyboardSafeArea);
    backgroundColor = returnFirstIfNotNil(backgroundColor, o.backgroundColor);
    borderRadius = returnFirstIfNotNil(borderRadius, o.borderRadius);
    animationDuration = returnFirstIfNotNil(animationDuration, o.animationDuration);
    backButtonBehavior = returnFirstIfNotNil(backButtonBehavior, o.backButtonBehavior);
    animationReverseDuration = returnFirstIfNotNil(animationReverseDuration, o.animationReverseDuration);
    enableSlideOff = returnFirstIfNotNil(enableSlideOff, o.enableSlideOff);
    onTap = returnFirstIfNotNil(onTap, o.onTap);
    onLongPress = returnFirstIfNotNil(onLongPress, o.onLongPress);
    onClose = returnFirstIfNotNil(onClose, o.onClose);
    onlyOne = returnFirstIfNotNil(onlyOne, o.onlyOne);
    crossPage = returnFirstIfNotNil(crossPage, o.crossPage);
    titleStyle = returnFirstIfNotNil(titleStyle, o.titleStyle);
    subTitleStyle = returnFirstIfNotNil(subTitleStyle, o.subTitleStyle);

    final hideCloseButtonV = returnFirstIfNotNilAndCast<bool>(hideCloseButton, o.hideCloseButton);
    final subTitleV = returnFirstIfNotNilAndCast<String?>(subTitle, o.subTitle);
    final closeIconV = returnFirstIfNotNilAndCast<Icon?>(closeIcon, o.closeIcon);

    assert(isNilOr<bool>([enableKeyboardSafeArea, enableSlideOff, hideCloseButtonV, crossPage, onlyOne]), 'Must be of bool type');
    assert(isNilOr<double>([borderRadius]), 'Must be of double type');
    assert(isNilOr<String>([subTitleV]), 'Must be of String type');

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
        subtitle: subTitleV == null ? null : (_) => Text(subTitleV, style: subTitleStyle),
        trailing: hideCloseButtonV ? null : (cancel) => IconButton(icon: closeIconV ?? o.closeIcon, onPressed: cancel));
  }

  /// Display a standard notification Toast.
  /// [leading], [title], [subtitle], [trailing], [contentPadding], [margin] - Refer to [ListTile].
  /// [enableSlideOff] - Whether sliding to dismiss is enabled.
  /// [align] - Alignment of the ToastContent area within the MainContent area.
  /// [dismissDirections] - Directions in which sliding to dismiss is allowed.
  /// [onTap] - Callback when the notification Toast is tapped.
  /// [onLongPress] - Callback when the notification Toast is long-pressed.
  /// [wrapAnimation] - See [showAnimationWidget.wrapAnimation], default value is null.
  /// [wrapToastAnimation] - See [showAnimationWidget.wrapToastAnimation], default value is [notificationAnimation].
  /// [animationDuration] - See [showAnimationWidget.animationDuration].
  /// [animationReverseDuration] - See [showAnimationWidget.animationReverseDuration].
  /// [duration] - See [showEnhancedWidget.duration].
  /// [onlyOne] - See [showEnhancedWidget.onlyOne].
  /// [crossPage] - See [showEnhancedWidget.crossPage].
  /// [onClose] - See [showEnhancedWidget.onClose].
  /// [backButtonBehavior] - See [showEnhancedWidget.backButtonBehavior].
  /// [backgroundColor] - Defaults to Theme.of(context).cardColor.
  /// [borderRadius] - Defaults to ThemeData.cardTheme.shape.
  /// [enableKeyboardSafeArea] - See [showEnhancedWidget.enableKeyboardSafeArea].
  ///
  ///显示一个标准的通知Toast
  ///[leading]_[title]_[subtitle]_[trailing]_[contentPadding]_[margin] 请看[ListTile]
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
      {ToastBuilder? leading = nilToastBuilder,
      ToastBuilder? title = nilToastBuilder,
      ToastBuilder? subtitle = nilToastBuilder,
      ToastBuilder? trailing = nilToastBuilder,
      WrapAnimation? wrapAnimation = nilWrapAnimation,
      WrapAnimation? wrapToastAnimation = nilWrapAnimation,
      GestureTapCallback? onTap = nilVoidCallback,
      Color? backgroundColor = nilColor,
      /*double*/ Object? borderRadius = nil,
      GestureLongPressCallback? onLongPress = nilVoidCallback,
      Alignment? align = nilAlignment,
      List<DismissDirection> dismissDirections = nilDismissDirectionList,
      BackButtonBehavior? backButtonBehavior = nilBackButtonBehavior,
      Duration? duration = nilDuration,
      Duration? animationDuration = nilDuration,
      Duration? animationReverseDuration = nilDuration,
      EdgeInsetsGeometry? contentPadding = nilEdgeInsets,
      EdgeInsetsGeometry? margin = nilEdgeInsets,
      VoidCallback? onClose = nilVoidCallback,
      /*bool*/ Object enableKeyboardSafeArea = nil,
      /*bool*/ Object enableSlideOff = nil,
      /*bool*/ Object crossPage = nil,
      /*bool*/ Object onlyOne = nil}) {
    var o = defaultOption.notification;

    leading = returnFirstIfNotNil(leading, o.leading);
    title = returnFirstIfNotNil(title, o.title);
    subtitle = returnFirstIfNotNil(subtitle, o.subtitle);
    trailing = returnFirstIfNotNil(trailing, o.trailing);
    wrapAnimation = returnFirstIfNotNil(wrapAnimation, o.wrapAnimation);
    wrapToastAnimation = returnFirstIfNotNil(wrapToastAnimation, o.wrapToastAnimation);
    onTap = returnFirstIfNotNil(onTap, o.onTap);
    backgroundColor = returnFirstIfNotNil(backgroundColor, o.backgroundColor);
    onLongPress = returnFirstIfNotNil(onLongPress, o.onLongPress);
    align = returnFirstIfNotNil(align, o.align);
    dismissDirections = returnFirstIfNotNil(dismissDirections, o.dismissDirections);
    backButtonBehavior = returnFirstIfNotNil(backButtonBehavior, o.backButtonBehavior);
    duration = returnFirstIfNotNil(duration, o.duration);
    animationDuration = returnFirstIfNotNil(animationDuration, o.animationDuration);
    animationReverseDuration = returnFirstIfNotNil(animationReverseDuration, o.animationReverseDuration);
    contentPadding = returnFirstIfNotNil(contentPadding, o.contentPadding);
    margin = returnFirstIfNotNil(margin, o.contentPadding);
    onClose = returnFirstIfNotNil(onClose, o.onClose);
    enableKeyboardSafeArea = returnFirstIfNotNil(enableKeyboardSafeArea, o.enableKeyboardSafeArea);
    enableSlideOff = returnFirstIfNotNil(enableSlideOff, o.enableSlideOff);
    crossPage = returnFirstIfNotNil(crossPage, o.crossPage);
    onlyOne = returnFirstIfNotNil(onlyOne, o.onlyOne);

    final borderRadiusV = returnFirstIfNotNilAndCast<double?>(borderRadius, o.borderRadius);

    assert(isNilOr<bool>([enableKeyboardSafeArea, enableSlideOff, crossPage, onlyOne]), 'Must be of bool type');
    assert(isNilOr<double>([borderRadiusV]), 'Must be of double type');

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
            margin: margin,
            color: backgroundColor,
            shape: borderRadiusV == null
                ? null
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusV),
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

  /// Display a custom notification Toast.
  /// [toastBuilder] - Builder function to generate the Widget to be displayed.
  /// [enableSlideOff] - Whether sliding to dismiss is enabled.
  /// [align] - Alignment of the ToastContent area within the MainContent area.
  /// [dismissDirections] - Directions in which sliding to dismiss is allowed.
  /// [wrapAnimation] - See [showAnimationWidget.wrapAnimation], default value is null.
  /// [wrapToastAnimation] - See [showAnimationWidget.wrapToastAnimation], default value is [notificationAnimation].
  /// [animationDuration] - See [showAnimationWidget.animationDuration].
  /// [animationReverseDuration] - See [showAnimationWidget.animationReverseDuration].
  /// [duration] - See [showEnhancedWidget.duration].
  /// [onlyOne] - See [showEnhancedWidget.onlyOne].
  /// [crossPage] - See [showEnhancedWidget.crossPage].
  /// [onClose] - See [showEnhancedWidget.onClose].
  /// [backButtonBehavior] - See [showEnhancedWidget.backButtonBehavior].
  /// [enableKeyboardSafeArea] - See [showEnhancedWidget.enableKeyboardSafeArea].
  ///
  ///显示一个自定义的通知Toast
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
      WrapAnimation? wrapAnimation = nilWrapAnimation,
      WrapAnimation? wrapToastAnimation = nilWrapAnimation,
      Alignment? align = nilAlignment,
      List<DismissDirection> dismissDirections = nilDismissDirectionList,
      Duration? duration = nilDuration,
      Duration? animationDuration = nilDuration,
      Duration? animationReverseDuration = nilDuration,
      VoidCallback? onClose = nilVoidCallback,
      BackButtonBehavior? backButtonBehavior = nilBackButtonBehavior,
      /*bool*/ Object enableKeyboardSafeArea = nil,
      /*bool*/ Object enableSlideOff = nil,
      /*bool*/ Object crossPage = nil,
      /*bool*/ Object onlyOne = nil,
      /*bool*/ Object useSafeArea = nil}) {
    var o = defaultOption.customNotification;

    wrapAnimation = returnFirstIfNotNil(wrapAnimation, o.wrapAnimation);
    wrapToastAnimation = returnFirstIfNotNil(wrapToastAnimation, o.wrapToastAnimation);
    align = returnFirstIfNotNil(align, o.align);
    dismissDirections = returnFirstIfNotNil(dismissDirections, o.dismissDirections);
    duration = returnFirstIfNotNil(duration, o.duration);
    animationReverseDuration = returnFirstIfNotNil(animationReverseDuration, o.animationReverseDuration);
    onClose = returnFirstIfNotNil(onClose, o.onClose);
    backButtonBehavior = returnFirstIfNotNil(backButtonBehavior, o.backButtonBehavior);
    enableKeyboardSafeArea = returnFirstIfNotNil(enableKeyboardSafeArea, o.enableKeyboardSafeArea);
    crossPage = returnFirstIfNotNil(crossPage, o.crossPage);
    onlyOne = returnFirstIfNotNil(onlyOne, o.onlyOne);
    useSafeArea = returnFirstIfNotNil(useSafeArea, o.useSafeArea);
    enableSlideOff = returnFirstIfNotNil(enableSlideOff, o.enableSlideOff);

    final animationDurationV = returnFirstIfNotNilAndCast<Duration?>(animationDuration, o.animationDuration);

    assert(isNilOr<bool>([enableKeyboardSafeArea, enableSlideOff, crossPage, onlyOne, useSafeArea]), 'Must be of bool type');

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
        animationDuration: animationDurationV ?? o.animationDuration,
        animationReverseDuration: animationReverseDuration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) {
          if (wrapToastAnimation != null) {
            child = wrapToastAnimation(controller, cancel, child);
          }
          if (align != null) {
            child = Align(alignment: align, child: child);
          }
          return useSafeArea == true ? SafeArea(child: child) : child;
        },
        toastBuilder: (cancelFunc) => NotificationToast(
            child: toastBuilder(cancelFunc), dismissDirections: dismissDirections, slideOffFunc: enableSlideOff == true ? cancelFunc : null),
        groupKey: notificationKey);
  }

  /// Display a standard text Toast.
  /// [text] - The text to be displayed.
  /// [contentColor] - Background color of the ToastContent area.
  /// [borderRadius] - BorderRadius of the ToastContent area.
  /// [textStyle] - Text style.
  /// [contentPadding] - Padding of the ToastContent area.
  /// [align] - Alignment of the ToastContent area within the MainContent area.
  /// [wrapAnimation] - See [showAnimationWidget.wrapAnimation], default value is null.
  /// [wrapToastAnimation] - See [showAnimationWidget.wrapToastAnimation], default value is [textAnimation].
  /// [animationDuration] - See [showAnimationWidget.animationDuration].
  /// [animationReverseDuration] - See [showAnimationWidget.animationReverseDuration].
  /// [backgroundColor] - See [showEnhancedWidget.backgroundColor].
  /// [duration] - See [showEnhancedWidget.duration].
  /// [onlyOne] - See [showEnhancedWidget.onlyOne].
  /// [clickClose] - See [showEnhancedWidget.clickClose].
  /// [crossPage] - See [showEnhancedWidget.crossPage].
  /// [onClose] - See [showEnhancedWidget.onClose].
  /// [backButtonBehavior] - See [showEnhancedWidget.backButtonBehavior].
  /// [enableKeyboardSafeArea] - See [showEnhancedWidget.enableKeyboardSafeArea].
  ///
  ///显示一个标准文本Toast
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
  static CancelFunc showText({
    required String text,
    WrapAnimation? wrapAnimation = nilWrapAnimation,
    WrapAnimation? wrapToastAnimation = nilWrapAnimation,
    Color backgroundColor = nilColor,
    Color contentColor = nilColor,
    BorderRadiusGeometry borderRadius = nilBorderRadius,
    TextStyle textStyle = nilTextStyle,
    AlignmentGeometry? align = nilAlignment,
    EdgeInsetsGeometry contentPadding = nilEdgeInsets,
    Duration? duration = nilDuration,
    Duration? animationDuration = nilDuration,
    Duration? animationReverseDuration = nilDuration,
    BackButtonBehavior? backButtonBehavior = nilBackButtonBehavior,
    VoidCallback? onClose = nilVoidCallback,
    /*bool*/ Object enableKeyboardSafeArea = nil,
    /*bool*/ Object clickClose = nil,
    /*bool*/ Object crossPage = nil,
    /*bool*/ Object onlyOne = nil,
  }) {
    var o = defaultOption.text;

    wrapAnimation = returnFirstIfNotNil(wrapAnimation, o.wrapAnimation);
    wrapToastAnimation = returnFirstIfNotNil(wrapToastAnimation, o.wrapToastAnimation);
    backgroundColor = returnFirstIfNotNil(backgroundColor, o.backgroundColor);
    contentColor = returnFirstIfNotNil(contentColor, o.contentColor);
    borderRadius = returnFirstIfNotNil(borderRadius, o.borderRadius);
    textStyle = returnFirstIfNotNil(textStyle, o.textStyle);
    align = returnFirstIfNotNil(align, o.align);
    contentPadding = returnFirstIfNotNil(contentPadding, o.contentPadding);
    duration = returnFirstIfNotNil(duration, o.duration);
    animationDuration = returnFirstIfNotNil(animationDuration, o.animationDuration);
    animationReverseDuration = returnFirstIfNotNil(animationReverseDuration, o.animationReverseDuration);
    backButtonBehavior = returnFirstIfNotNil(backButtonBehavior, o.backButtonBehavior);
    onClose = returnFirstIfNotNil(onClose, o.onClose);
    enableKeyboardSafeArea = returnFirstIfNotNil(enableKeyboardSafeArea, o.enableKeyboardSafeArea);
    clickClose = returnFirstIfNotNil(clickClose, o.clickClose);
    crossPage = returnFirstIfNotNil(crossPage, o.crossPage);
    onlyOne = returnFirstIfNotNil(onlyOne, o.onlyOne);

    assert(isNilOr<bool>([enableKeyboardSafeArea, clickClose, crossPage, onlyOne]), 'Must be of bool type');

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

  /// Display a custom text Toast.
  /// [toastBuilder] - A builder function that generates the widget to be displayed.
  /// [align] - Alignment of the ToastContent area within the MainContent area.
  /// [wrapAnimation] - See [showAnimationWidget.wrapAnimation], default value is null.
  /// [wrapToastAnimation] - See [showAnimationWidget.wrapToastAnimation], default value is [textAnimation].
  /// [animationDuration] - See [showAnimationWidget.animationDuration].
  /// [animationReverseDuration] - See [showAnimationWidget.animationReverseDuration].
  /// [ignoreContentClick] - See [showEnhancedWidget.ignoreContentClick].
  /// [duration] - See [showEnhancedWidget.duration].
  /// [onlyOne] - See [showEnhancedWidget.onlyOne].
  /// [clickClose] - See [showEnhancedWidget.clickClose].
  /// [crossPage] - See [showEnhancedWidget.crossPage].
  /// [backgroundColor] - See [showEnhancedWidget.backgroundColor].
  /// [onClose] - See [showEnhancedWidget.onClose].
  /// [backButtonBehavior] - See [showEnhancedWidget.backButtonBehavior].
  /// [enableKeyboardSafeArea] - See [showEnhancedWidget.enableKeyboardSafeArea].
  ///
  ///显示一个自定义的文本Toast
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
  static CancelFunc showCustomText({
    required ToastBuilder toastBuilder,
    WrapAnimation? wrapAnimation = nilWrapAnimation,
    WrapAnimation? wrapToastAnimation = nilWrapAnimation,
    AlignmentGeometry? align = nilAlignment,
    Color backgroundColor = nilColor,
    Duration? duration = nilDuration,
    Duration? animationDuration = nilDuration,
    Duration? animationReverseDuration = nilDuration,
    VoidCallback? onClose = nilVoidCallback,
    BackButtonBehavior? backButtonBehavior = nilBackButtonBehavior,
    /*bool*/ Object enableKeyboardSafeArea = nil,
    /*bool*/ Object crossPage = nil,
    /*bool*/ Object clickClose = nil,
    /*bool*/ Object ignoreContentClick = nil,
    /*bool*/ Object onlyOne = nil,
    /*bool*/ Object useSafeArea = nil,
  }) {
    var o = defaultOption.customText;

    wrapAnimation = returnFirstIfNotNil(wrapAnimation, o.wrapAnimation);
    wrapToastAnimation = returnFirstIfNotNil(wrapToastAnimation, o.wrapToastAnimation);
    align = returnFirstIfNotNil(align, o.align);
    backgroundColor = returnFirstIfNotNil(backgroundColor, o.backgroundColor);
    duration = returnFirstIfNotNil(duration, o.duration);
    animationDuration = returnFirstIfNotNil(animationDuration, o.animationDuration);
    animationReverseDuration = returnFirstIfNotNil(animationReverseDuration, o.animationReverseDuration);
    onClose = returnFirstIfNotNil(onClose, o.onClose);
    backButtonBehavior = returnFirstIfNotNil(backButtonBehavior, o.backButtonBehavior);
    enableKeyboardSafeArea = returnFirstIfNotNil(enableKeyboardSafeArea, o.enableKeyboardSafeArea);
    crossPage = returnFirstIfNotNil(crossPage, o.crossPage);
    clickClose = returnFirstIfNotNil(clickClose, o.clickClose);
    ignoreContentClick = returnFirstIfNotNil(ignoreContentClick, o.ignoreContentClick);
    onlyOne = returnFirstIfNotNil(onlyOne, o.onlyOne);
    useSafeArea = returnFirstIfNotNil(useSafeArea, o.useSafeArea);

    assert(isNilOr<bool>([enableKeyboardSafeArea, clickClose, crossPage, onlyOne, ignoreContentClick, useSafeArea]), 'Must be of bool type');

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
        animationDuration: animationDuration ?? o.animationDuration,
        animationReverseDuration: animationReverseDuration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) {
          if (wrapToastAnimation != null) {
            child = wrapToastAnimation(controller, cancel, child);
          }
          if (align != null) {
            child = Align(alignment: align, child: child);
          }
          return useSafeArea == true ? SafeArea(child: child) : child;
        },
        toastBuilder: toastBuilder);
  }

  /// Display a standard loading Toast.
  /// [align] - Alignment of the ToastContent area within the MainContent area.
  /// [wrapAnimation] - See [showAnimationWidget.wrapAnimation], default value is [loadingAnimation].
  /// [wrapToastAnimation] - See [showAnimationWidget.wrapToastAnimation], default value is null.
  /// [animationDuration] - See [showAnimationWidget.animationDuration].
  /// [animationReverseDuration] - See [showAnimationWidget.animationReverseDuration].
  /// [duration] - See [showEnhancedWidget.duration].
  /// [allowClick] - See [showEnhancedWidget.allowClick].
  /// [clickClose] - See [showEnhancedWidget.clickClose].
  /// [crossPage] - See [showEnhancedWidget.crossPage].
  /// [backgroundColor] - See [showEnhancedWidget.backgroundColor].
  /// [onClose] - See [showEnhancedWidget.onClose].
  /// [backButtonBehavior] - See [showEnhancedWidget.backButtonBehavior].
  /// [enableKeyboardSafeArea] - See [showEnhancedWidget.enableKeyboardSafeArea].
  ///
  ///显示一个标准的加载Toast
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
    WrapAnimation? wrapAnimation = nilWrapAnimation,
    WrapAnimation? wrapToastAnimation = nilWrapAnimation,
    Alignment align = nilAlignment,
    BackButtonBehavior? backButtonBehavior = nilBackButtonBehavior,
    /*bool*/ Object crossPage = nil,
    /*bool*/ Object clickClose = nil,
    /*bool*/ Object allowClick = nil,
    /*bool*/ Object enableKeyboardSafeArea = nil,
    VoidCallback? onClose = nilVoidCallback,
    Duration? duration = nilDuration,
    Duration? animationDuration = nilDuration,
    Duration? animationReverseDuration = nilDuration,
    Color backgroundColor = nilColor,
  }) {
    var o = defaultOption.loading;

    wrapAnimation = returnFirstIfNotNil(wrapAnimation, o.wrapAnimation);
    wrapToastAnimation = returnFirstIfNotNil(wrapToastAnimation, o.wrapToastAnimation);
    align = returnFirstIfNotNil(align, o.align);
    backButtonBehavior = returnFirstIfNotNil(backButtonBehavior, o.backButtonBehavior);
    crossPage = returnFirstIfNotNil(crossPage, o.crossPage);
    clickClose = returnFirstIfNotNil(clickClose, o.clickClose);
    allowClick = returnFirstIfNotNil(allowClick, o.allowClick);
    enableKeyboardSafeArea = returnFirstIfNotNil(enableKeyboardSafeArea, o.enableKeyboardSafeArea);
    onClose = returnFirstIfNotNil(onClose, o.onClose);
    duration = returnFirstIfNotNil(duration, o.duration);
    animationDuration = returnFirstIfNotNil(animationDuration, o.animationDuration);
    animationReverseDuration = returnFirstIfNotNil(animationReverseDuration, o.animationReverseDuration);
    backgroundColor = returnFirstIfNotNil(backgroundColor, o.backgroundColor);

    assert(isNilOr<bool>([enableKeyboardSafeArea, clickClose, crossPage, allowClick]), 'Must be of bool type');

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

  /// Display a custom loading Toast.
  /// [toastBuilder] - Builder function to generate the widget to display.
  /// [align] - Alignment of the ToastContent area within the MainContent area.
  /// [wrapAnimation] - See [showAnimationWidget.wrapAnimation], default value is [loadingAnimation].
  /// [wrapToastAnimation] - See [showAnimationWidget.wrapToastAnimation], default value is null.
  /// [animationDuration] - See [showAnimationWidget.animationDuration].
  /// [animationReverseDuration] - See [showAnimationWidget.animationReverseDuration].
  /// [ignoreContentClick] - See [showEnhancedWidget.ignoreContentClick].
  /// [duration] - See [showEnhancedWidget.duration].
  /// [allowClick] - See [showEnhancedWidget.allowClick].
  /// [clickClose] - See [showEnhancedWidget.clickClose].
  /// [crossPage] - See [showEnhancedWidget.crossPage].
  /// [backgroundColor] - See [showEnhancedWidget.backgroundColor].
  /// [onClose] - See [showEnhancedWidget.onClose].
  /// [backButtonBehavior] - See [showEnhancedWidget.backButtonBehavior].
  /// [enableKeyboardSafeArea] - See [showEnhancedWidget.enableKeyboardSafeArea].
  ///
  ///显示一个自定义的加载Toast
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
    WrapAnimation? wrapAnimation = nilWrapAnimation,
    WrapAnimation? wrapToastAnimation = nilWrapAnimation,
    Alignment? align = nilAlignment,
    BackButtonBehavior? backButtonBehavior = nilBackButtonBehavior,
    /*bool*/ Object clickClose = nil,
    /*bool*/ Object allowClick = nil,
    /*bool*/ Object ignoreContentClick = nil,
    /*bool*/ Object crossPage = nil,
    /*bool*/ Object enableKeyboardSafeArea = nil,
    VoidCallback? onClose = nilVoidCallback,
    Duration? duration = nilDuration,
    Duration? animationDuration = nilDuration,
    Duration? animationReverseDuration = nilDuration,
    Color backgroundColor = nilColor,
    /*bool*/ Object useSafeArea = nil,
  }) {
    var o = defaultOption.customLoading;

    wrapAnimation = returnFirstIfNotNil(wrapAnimation, o.wrapAnimation);
    wrapToastAnimation = returnFirstIfNotNil(wrapToastAnimation, o.wrapToastAnimation);
    align = returnFirstIfNotNil(align, o.align);
    backButtonBehavior = returnFirstIfNotNil(backButtonBehavior, o.backButtonBehavior);
    clickClose = returnFirstIfNotNil(clickClose, o.clickClose);
    allowClick = returnFirstIfNotNil(allowClick, o.allowClick);
    ignoreContentClick = returnFirstIfNotNil(ignoreContentClick, o.ignoreContentClick);
    crossPage = returnFirstIfNotNil(crossPage, o.crossPage);
    enableKeyboardSafeArea = returnFirstIfNotNil(enableKeyboardSafeArea, o.enableKeyboardSafeArea);
    onClose = returnFirstIfNotNil(onClose, o.onClose);
    duration = returnFirstIfNotNil(duration, o.duration);
    animationDuration = returnFirstIfNotNil(animationDuration, o.animationDuration);
    animationReverseDuration = returnFirstIfNotNil(animationReverseDuration, o.animationReverseDuration);
    backgroundColor = returnFirstIfNotNil(backgroundColor, o.backgroundColor);
    useSafeArea = returnFirstIfNotNil(useSafeArea, o.useSafeArea);

    assert(isNilOr<bool>([enableKeyboardSafeArea, clickClose, crossPage, allowClick, ignoreContentClick, useSafeArea]), 'Must be of bool type');

    return showAnimationWidget(
        groupKey: loadKey,
        enableKeyboardSafeArea: enableKeyboardSafeArea,
        toastBuilder: toastBuilder,
        backButtonBehavior: backButtonBehavior,
        animationDuration: animationDuration ?? o.animationDuration,
        animationReverseDuration: animationReverseDuration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) {
          if (wrapToastAnimation != null) {
            child = wrapToastAnimation(controller, cancel, child);
          }
          if (align != null) {
            child = Align(alignment: align, child: child);
          }
          return useSafeArea == true ? SafeArea(child: child) : child;
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

  ///This method is generally used in `dispose` to ensure that the Toast is closed properly.
  ///It prevents scenarios where the developer forgets to close it manually or if there's an API request error that prevents the `CancelFunc` from executing.
  ///This ensures that the user can interact with the app normally.
  ///此方法一般使用在dispose里面,防止因为开发人员没有主动去关闭,或者是请求api时的出现异常导致CancelFunc方法没有执行到等等,导致用户点击不了app
  static void closeAllLoading() {
    //以此方式移除将不会触发关闭动画
    removeAll(loadKey);
  }

  /// Displays a positioned Toast.
  /// This method can display the Toast around a given Widget (usually a Button) or at a specific offset.
  /// [attachedBuilder] is the builder function to generate the Widget to be displayed.
  /// [targetContext] is the target Widget (usually a button). It's usually wrapped in a [Builder] to obtain the BuildContext.
  /// [target] is the target [Offset]. The offset is calculated relative to the top-left corner of the screen.
  /// You can either use [target] or [targetContext], not both.
  /// [verticalOffset] is the vertical offset, and it depends on [preferDirection]. It applies in different directions based on the direction.
  /// [horizontalOffset] is the horizontal offset and depends on [preferDirection]. It applies in different directions based on the direction.
  /// [preferDirection] is the preferred direction. If space allows, it will prefer to display in that direction.
  /// [enableSafeArea] If true, the toast ensures it doesn't display over the app status bar (it means it's safe); false otherwise.
  /// [wrapAnimation] Please refer to [showAnimationWidget.wrapAnimation]. Default value is null.
  /// [wrapToastAnimation] Please refer to [showAnimationWidget.wrapToastAnimation]. Default value is [attachedAnimation].
  /// [animationDuration] Please refer to [showAnimationWidget.animationDuration].
  /// [animationReverseDuration] Please refer to [showAnimationWidget.animationReverseDuration].
  /// [duration] Please refer to [showEnhancedWidget.duration].
  /// [ignoreContentClick] Please refer to [showEnhancedWidget.ignoreContentClick].
  /// [onlyOne] Please refer to [showEnhancedWidget.onlyOne].
  /// [allowClick] Please refer to [showEnhancedWidget.allowClick].
  /// [onClose] Please refer to [showEnhancedWidget.onClose].
  /// [enableKeyboardSafeArea] Please refer to [showEnhancedWidget.enableKeyboardSafeArea].
  ///
  ///显示一个定位Toast
  ///该方法可以在某个Widget(一般是Button)或者给定一个offset周围显示
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
  static CancelFunc showAttachedWidget({
    required ToastBuilder attachedBuilder,
    BuildContext? targetContext,
    Offset? target,
    WrapAnimation? wrapAnimation = nilWrapAnimation,
    WrapAnimation? wrapToastAnimation = nilWrapAnimation,
    Color backgroundColor = nilColor,
    /*double*/ Object verticalOffset = nil,
    /*double*/ Object horizontalOffset = nil,
    Duration? duration = nilDuration,
    Duration? animationDuration = nilDuration,
    Duration? animationReverseDuration = nilDuration,
    PreferDirection? preferDirection = nilPreferDirection,
    VoidCallback? onClose = nilVoidCallback,
    /*bool*/ Object ignoreContentClick = nil,
    /*bool*/ Object onlyOne = nil,
    /*bool*/ Object allowClick = nil,
    /*bool*/ Object enableKeyboardSafeArea = nil,
    /*bool*/ Object enableSafeArea = nil,
  }) {
    var o = defaultOption.attached;

    wrapAnimation = returnFirstIfNotNil(wrapAnimation, o.wrapAnimation);
    wrapToastAnimation = returnFirstIfNotNil(wrapToastAnimation, o.wrapToastAnimation);
    backgroundColor = returnFirstIfNotNil(backgroundColor, o.backgroundColor);
    duration = returnFirstIfNotNil(duration, o.duration);
    animationDuration = returnFirstIfNotNil(animationDuration, o.animationDuration);
    animationReverseDuration = returnFirstIfNotNil(animationReverseDuration, o.animationReverseDuration);
    preferDirection = returnFirstIfNotNil(preferDirection, o.preferDirection);
    onClose = returnFirstIfNotNil(onClose, o.onClose);
    ignoreContentClick = returnFirstIfNotNil(ignoreContentClick, o.ignoreContentClick);
    onlyOne = returnFirstIfNotNil(onlyOne, o.onlyOne);
    allowClick = returnFirstIfNotNil(allowClick, o.allowClick);
    enableKeyboardSafeArea = returnFirstIfNotNil(enableKeyboardSafeArea, o.enableKeyboardSafeArea);
    enableSafeArea = returnFirstIfNotNil(enableSafeArea, o.enableSafeArea);

    final verticalOffsetV = returnFirstIfNotNilAndCast<double>(verticalOffset, o.verticalOffset);
    final horizontalOffsetV = returnFirstIfNotNilAndCast<double>(horizontalOffset, o.horizontalOffset);

    assert(verticalOffsetV >= 0.0, 'must be a positive number');
    assert(verticalOffsetV >= 0.0, 'must be a positive number');
    assert(!(targetContext != null && target != null), 'targetContext and target cannot coexist');
    assert(targetContext != null || target != null, 'targetContext and target must exist one');

    assert(isNilOr<bool>([enableKeyboardSafeArea, onlyOne, enableSafeArea, allowClick, ignoreContentClick]), 'Must be of bool type');
    assert(isNilOr<double>([verticalOffsetV, horizontalOffsetV]), 'Must be of bool type');

    Rect targetRect;
    if (target == null) {
      RenderObject renderObject = targetContext!.findRenderObject()!;
      if (renderObject is RenderBox) {
        final position = renderObject.localToGlobal(Offset.zero);
        targetRect = Rect.fromLTWH(position.dx, position.dy, renderObject.size.width, renderObject.size.height);
      } else {
        throw Exception('context.findRenderObject() return result must be RenderBox class');
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
        animationDuration: animationDuration ?? o.animationDuration,
        animationReverseDuration: animationReverseDuration,
        duration: duration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) => KeyboardVisibility(
              onKeyboardVisibilityChanged: (open) {
                if (open) {
                  cancel();
                }
              },
              child: Builder(
                builder: (context) {
                  return CustomSingleChildLayout(
                      delegate: PositionDelegate(
                          target: targetRect,
                          paddingTop: MediaQuery.of(context).padding.top,
                          verticalOffset: verticalOffsetV,
                          horizontalOffset: horizontalOffsetV,
                          enableSafeArea: enableSafeArea == true,
                          preferDirection: preferDirection),
                      child: wrapToastAnimation != null ? wrapToastAnimation(controller, cancel, child) : child);
                }
              ),
            ),
        toastBuilder: attachedBuilder);
  }

  /// Displays a Toast that uses Animation.
  /// For usage, refer to:
  /// [BotToast.showCustomNotification]
  /// [BotToast.showCustomText]
  /// [BotToast.showCustomLoading]
  /// [BotToast.showAttachedWidget]
  ///
  /// [toastBuilder] is the builder function to generate the Widget to be displayed.
  /// [animationDuration] is the duration of the forward animation, which is equivalent to [AnimationController.duration]. It's recommended not to exceed [duration].
  /// [animationReverseDuration] is the duration of the reverse animation, which is equivalent to [AnimationController.reverseDuration].
  ///
  /// [wrapAnimation] wraps the animation of the MainContent area and can be used for custom animations. If null, it indicates no animation is needed. Using this function does not necessarily require using animations; it can also perform additional widget wrapping.
  ///
  /// [wrapToastAnimation] wraps the animation of the ToastContent area and can be used for custom animations. If null, it indicates no animation is needed. Using this function does not necessarily require using animations; it can also perform additional widget wrapping.
  ///
  /// [key] Please refer to [showEnhancedWidget.key].
  /// [groupKey] Please refer to [showEnhancedWidget.groupKey].
  /// [crossPage] Please refer to [showEnhancedWidget.crossPage].
  /// [allowClick] Please refer to [showEnhancedWidget.allowClick].
  /// [clickClose] Please refer to [showEnhancedWidget.clickClose].
  /// [ignoreContentClick] Please refer to [showEnhancedWidget.ignoreContentClick].
  /// [onlyOne] Please refer to [showEnhancedWidget.onlyOne].
  /// [backgroundColor] Please refer to [showEnhancedWidget.backgroundColor].
  /// [duration] Please refer to [showEnhancedWidget.duration].
  /// [onClose] Please refer to [showEnhancedWidget.onClose].
  /// [backButtonBehavior] Please refer to [showEnhancedWidget.backButtonBehavior].
  /// [enableKeyboardSafeArea] Please refer to [showEnhancedWidget.enableKeyboardSafeArea].
  ///
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
    Duration? animationReverseDuration = nilDuration,
    WrapAnimation? wrapAnimation = nilWrapAnimation,
    WrapAnimation? wrapToastAnimation = nilWrapAnimation,
    BackButtonBehavior? backButtonBehavior = nilBackButtonBehavior,
    /*bool*/ Object crossPage = nil,
    /*bool*/ Object allowClick = nil,
    /*bool*/ Object clickClose = nil,
    /*bool*/ Object ignoreContentClick = nil,
    /*bool*/ Object onlyOne = nil,
    /*bool*/ Object enableKeyboardSafeArea = nil,
    Color backgroundColor = nilColor,
    Duration? duration = nilDuration,
    VoidCallback? onClose = nilVoidCallback,
    UniqueKey? key,
    String? groupKey,
  }) {
    var o = defaultOption.animation;

    animationReverseDuration = returnFirstIfNotNil(animationReverseDuration, o.animationReverseDuration);
    wrapAnimation = returnFirstIfNotNil(wrapAnimation, o.wrapAnimation);
    wrapToastAnimation = returnFirstIfNotNil(wrapToastAnimation, o.wrapToastAnimation);
    backButtonBehavior = returnFirstIfNotNil(backButtonBehavior, o.backButtonBehavior);
    crossPage = returnFirstIfNotNil(crossPage, o.crossPage);
    allowClick = returnFirstIfNotNil(allowClick, o.allowClick);
    clickClose = returnFirstIfNotNil(clickClose, o.clickClose);
    ignoreContentClick = returnFirstIfNotNil(ignoreContentClick, o.ignoreContentClick);
    onlyOne = returnFirstIfNotNil(onlyOne, o.onlyOne);
    enableKeyboardSafeArea = returnFirstIfNotNil(enableKeyboardSafeArea, o.enableKeyboardSafeArea);
    backgroundColor = returnFirstIfNotNil(backgroundColor, o.backgroundColor);
    duration = returnFirstIfNotNil(duration, o.duration);
    onClose = returnFirstIfNotNil(onClose, o.onClose);

    assert(isNilOr<bool>([enableKeyboardSafeArea, onlyOne, clickClose, allowClick, ignoreContentClick, crossPage]), 'Must be of bool type');

    AnimationController? controller = _createAnimationController(animationDuration, reverseDuration: animationReverseDuration);

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
                  child: wrapAnimation != null ? wrapAnimation(controller!, cancel, child) : child),
            ),
        toastBuilder: (cancelFunc) =>
            wrapToastAnimation != null ? wrapToastAnimation(controller!, cancelFunc, toastBuilder(cancelFunc)) : toastBuilder(cancelFunc));
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

  /// Displays an enhanced Toast with many built-in features such as automatic timing closure, auto-closure on screen tap, and closure upon leaving the current Route.
  /// Core method, for detailed usage, refer to:
  /// [BotToast.showAnimationWidget]
  ///
  /// [toastBuilder] is the builder function to generate the Widget to be displayed.
  ///
  /// [key] represents a credential for this Toast. With this key, you can remove the Widget defined by the current key using [remove].
  ///
  /// [groupKey] represents a group key, mainly used for [removeAll] and [remove].
  ///
  /// [crossPage] displays across pages. If true, this Toast will appear across multiple Routes.
  /// If false, it will automatically close when the current Route changes, for example, [Navigator.push] - [Navigator.pop].
  ///
  /// [allowClick] determines whether normal clicking to trigger events is allowed while this Toast is displayed.
  ///
  /// [clickClose] determines whether the Toast should automatically close when the screen is tapped to trigger an event.
  ///
  /// [ignoreContentClick] determines whether to ignore the ToastContext area.
  /// When this parameter is true, user clicks within the ToastContext area will be able to reach the Page normally,
  /// in other words, it's transparent (even if the Toast background color is not transparent).
  /// If false, it behaves the opposite way.
  ///
  /// [onlyOne] indicates whether only one Toast should exist within the same group at the same time. Groups are distinguished by [groupKey].
  ///
  /// [closeFunc] is a function mainly intended to perform actions before closing the Toast, such as triggering [AnimationController] to start and waiting for the animation to complete before closing.
  ///
  /// [backgroundColor] is the background color of the MainContent area.
  ///
  /// [wrapWidget] is a wrapping function that can be used to wrap the MainContent area. For example, [showCustomLoading] wraps an animation
  /// to give the MainContent area animation.
  ///
  /// [duration] is the duration of the Toast. If null, it won't close automatically. If not null, it will automatically close after the specified time.
  ///
  /// [onClose] is called when the Toast is closed.
  ///
  /// [enableKeyboardSafeArea] determines whether to enable the keyboard safe area to prevent the keyboard from covering the Toast.
  ///
  /// [backButtonBehavior] defines the behavior when the physical back button (on Android or equivalent) is pressed. Note that this is not the back button on the navigation bar.
  /// If [ignore], it intercepts the back event.
  /// If [close], it closes the toast and intercepts the event, stopping it from propagating.
  /// If null or [none], it doesn't intercept the event.
  ///
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
  static CancelFunc showEnhancedWidget({
    required ToastBuilder toastBuilder,
    UniqueKey? key,
    String? groupKey,
    /*bool*/ Object crossPage = nil,
    /*bool*/ Object allowClick = nil,
    /*bool*/ Object clickClose = nil,
    /*bool*/ Object ignoreContentClick = nil,
    /*bool*/ Object onlyOne = nil,
    /*bool*/ Object enableKeyboardSafeArea = nil,
    BackButtonBehavior? backButtonBehavior = nilBackButtonBehavior,
    FutureFunc? closeFunc = nilFutureFunc,
    VoidCallback? onClose = nilVoidCallback,
    Color backgroundColor = nilColor,
    WrapWidget? warpWidget = nilWrapWidget,
    Duration? duration = nilDuration,
  }) {
    // ignore: unnecessary_null_comparison
    assert(enableKeyboardSafeArea != null);

    var o = defaultOption.enhanced;

    crossPage = returnFirstIfNotNil(crossPage, o.crossPage);
    allowClick = returnFirstIfNotNil(allowClick, o.allowClick);
    clickClose = returnFirstIfNotNil(clickClose, o.clickClose);
    ignoreContentClick = returnFirstIfNotNil(ignoreContentClick, o.ignoreContentClick);
    onlyOne = returnFirstIfNotNil(onlyOne, o.onlyOne);
    enableKeyboardSafeArea = returnFirstIfNotNil(enableKeyboardSafeArea, o.enableKeyboardSafeArea);
    backButtonBehavior = returnFirstIfNotNil(backButtonBehavior, o.backButtonBehavior);
    closeFunc = returnFirstIfNotNil(closeFunc, o.closeFunc);
    onClose = returnFirstIfNotNil(onClose, o.onClose);
    backgroundColor = returnFirstIfNotNil(backgroundColor, o.backgroundColor);
    warpWidget = returnFirstIfNotNil(warpWidget, o.warpWidget);
    duration = returnFirstIfNotNil(duration, o.duration);

    assert(isNilOr<bool>([enableKeyboardSafeArea, onlyOne, clickClose, allowClick, ignoreContentClick, crossPage]), 'Must be of bool type');

    //由于cancelFunc一开始是为空的,所以在赋值之前需要在闭包里使用
    late final CancelFunc cancelFunc;
    final CancelFunc dismissFunc = () async {
      await closeFunc?.call();
      cancelFunc();
    };

    //onlyOne 功能
    final List<CancelFunc> cache = (cacheCancelFunc[groupKey ?? defaultKey] ??= []);
    if (onlyOne == true) {
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
    if (!(crossPage == true)) {
      observerProxy = BotToastNavigatorObserverProxy.all(dismissFunc);
      BotToastNavigatorObserver.register(observerProxy);
    }

    //拦截点击返回事件
    VoidCallback? unRegisterFunc;
    if (backButtonBehavior == BackButtonBehavior.ignore) {
      unRegisterFunc = BotToastWidgetsBindingObserver.singleton.registerPopListener(() {
        return true;
      });
    } else if (backButtonBehavior == BackButtonBehavior.close) {
      unRegisterFunc = BotToastWidgetsBindingObserver.singleton.registerPopListener(() {
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
            enable: enableKeyboardSafeArea == true,
            child: ProxyDispose(disposeCallback: () {
              cache.remove(dismissFunc);
              if (observerProxy != null) {
                BotToastNavigatorObserver.unregister(observerProxy);
              }
              timer?.cancel();
              onClose?.call();
              unRegisterFunc?.call();
            }, child: Builder(builder: (BuildContext context) {
              final TextStyle textStyle = Theme.of(context).textTheme.bodyMedium!;
              Widget child = DefaultTextStyle(
                  style: textStyle,
                  child: Stack(children: <Widget>[
                    Listener(
                      onPointerDown: clickClose == true ? (_) => dismissFunc() : null,
                      behavior: allowClick == true ? HitTestBehavior.translucent : HitTestBehavior.opaque,
                      child: const SizedBox.expand(),
                    ),
                    IgnorePointer(
                      child: Container(color: backgroundColor),
                    ),
                    IgnorePointer(
                      ignoring: ignoreContentClick == true,
                      child: toastBuilder(dismissFunc),
                    )
                  ]));
              return warpWidget != null ? warpWidget(dismissFunc, child) : child;
            })),
          );
        });

    return dismissFunc;
  }

  /// Displays a Widget on the screen that can persist across multiple pages.
  /// [toastBuilder] is the builder function to generate the Widget to be displayed.
  /// [key] represents a credential for this Toast. With this key, you can remove the Widget defined by the current key using [remove].
  /// [groupKey] represents a group key, mainly used for [removeAll] and [remove].
  /// [CancelFunc] is the close function, and actively calling it will close this Toast.
  /// This is a core method.
  ///
  ///显示一个Widget在屏幕上,该Widget可以跨多个页面存在
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///[key] 代表此Toast的一个凭证,凭此key可以删除当前key所定义的Widget,[remove]
  ///[groupKey] 代表分组的key,主要用于[removeAll]和[remove]
  ///[CancelFunc] 关闭函数,主动调用将会关闭此Toast
  ///这是个核心方法
  static CancelFunc showWidget({required ToastBuilder toastBuilder, UniqueKey? key, String? groupKey}) {
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

  static AnimationController _createAnimationController(Duration duration, {Duration? reverseDuration}) {
    return AnimationController(vsync: TickerProviderImpl(), duration: duration, reverseDuration: reverseDuration);
  }
}
