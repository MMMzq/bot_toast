import 'dart:async';

import 'package:flutter/material.dart';

import 'basis.dart';
import 'bot_toast_init.dart';
import 'keyboard_safe_area.dart';
import 'keyboard_visibility.dart';
import 'toast.dart';
import 'toast_navigator_observer.dart';
import 'toast_option_v2.dart';
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

class BotToastV2 {
  static CancelFunc showSimpleNotification({
    required String title,
    OptionFunc<SimpleNotificationOption>? option,
  }) {
    final SimpleNotificationOption o = SimpleNotificationOption();
    option?.call(o);

    return showNotification(
        wrapAnimation: o.wrapAnimation,
        wrapToastAnimation: o.wrapToastAnimation,
        align: align,
        dismissDirections: dismissDirections,
        duration: o.duration,
        enableKeyboardSafeArea: o.enableKeyboardSafeArea,
        backgroundColor: o.backgroundColor,
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
  static CancelFunc showNotification({OptionFunc<NotificationOption>? option}) {
    NotificationOption o = NotificationOption.defaultFunc();
    option?.call(o);

    return BotToast.showNotification(
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         leading: o. leading,
         title: o. title,
         subtitle: o. subtitle,
         trailing: o. trailing,
         wrapAnimation: o. wrapAnimation,
         wrapToastAnimation: o. wrapToastAnimation,
         onTap: o. onTap,
         backgroundColor: o. backgroundColor,
         borderRadius: o. borderRadius,
         onLongPress: o. onLongPress,
         align: o. align,
        DismissDirection: o.DismissDirection,
         backButtonBehavior: o. backButtonBehavior,
         duration: o. duration
         animationDuration: o.animationDuration
         animationReverseDuration: o.animationReverseDuration
         contentPadding: o.contentPadding
         onClose: o.onClose
        enableKeyboardSafeArea:o.enableKeyboardSafeArea
        enableSlideOff: o.enableSlideOff
        crossPage: o.crossPage
        onlyOne: o.onlyOne



    );
  }

  static CancelFunc showCustomNotification(
      {required ToastBuilder toastBuilder,
      OptionFunc<CustomNotificationOption>? option}) {
    CustomNotificationOption o = CustomNotificationOption.defaultFunc();
    option?.call(o);

    return BotToast.showCustomNotification(
      crossPage: o.crossPage,
      enableKeyboardSafeArea: o.enableKeyboardSafeArea,
      onlyOne: o.onlyOne,
      onClose: o.onClose,
      duration: o.duration,
      backButtonBehavior: o.backButtonBehavior,
      animationDuration: o.animationDuration,
      animationReverseDuration: o.animationReverseDuration,
      wrapAnimation: o.wrapAnimation,
      wrapToastAnimation: o.wrapToastAnimation,
      toastBuilder: toastBuilder,
    );
  }

  static CancelFunc showText(
      {required String text, OptionFunc<TextOption>? option}) {
    TextOption o = TextOption.defaultFunc();
    option?.call(o);
    return BotToast.showText(
        wrapAnimation: o.wrapAnimation,
        wrapToastAnimation: o.wrapToastAnimation,
        duration: o.duration,
        animationDuration: o.animationDuration,
        animationReverseDuration: o.animationReverseDuration,
        crossPage: o.crossPage,
        backgroundColor: o.backgroundColor,
        clickClose: o.clickClose,
        backButtonBehavior: o.backButtonBehavior,
        onClose: o.onClose,
        enableKeyboardSafeArea: o.enableKeyboardSafeArea,
        onlyOne: o.onlyOne,
        align: o.align,
        text: text);
  }

  static CancelFunc showCustomText(
      {required ToastBuilder toastBuilder,
      OptionFunc<CustomTextOption>? option}) {
    CustomTextOption o = CustomTextOption.defaultFunc();
    option?.call(o);

    return BotToast.showCustomText(
        clickClose: o.clickClose,
        enableKeyboardSafeArea: o.enableKeyboardSafeArea,
        onlyOne: o.onlyOne,
        crossPage: o.crossPage,
        ignoreContentClick: o.ignoreContentClick,
        backgroundColor: o.backgroundColor,
        backButtonBehavior: o.backButtonBehavior,
        onClose: o.onClose,
        duration: o.duration,
        animationDuration: o.animationDuration,
        animationReverseDuration: o.animationReverseDuration,
        wrapAnimation: o.wrapAnimation,
        wrapToastAnimation: o.wrapToastAnimation,
        toastBuilder: toastBuilder);
  }

  static CancelFunc showLoading({OptionFunc<LoadingOption>? option}) {
    LoadingOption o = LoadingOption.defaultFunc();
    option?.call(o);
    return BotToast.showLoading(
        wrapAnimation: o.wrapAnimation,
        wrapToastAnimation: o.wrapToastAnimation,
        align: o.align,
        enableKeyboardSafeArea: o.enableKeyboardSafeArea,
        backButtonBehavior: o.backButtonBehavior,
        clickClose: o.clickClose,
        allowClick: o.allowClick,
        crossPage: o.crossPage,
        onClose: o.onClose,
        duration: o.duration,
        animationDuration: o.animationDuration,
        animationReverseDuration: o.animationReverseDuration,
        backgroundColor: o.backgroundColor);
  }

  static CancelFunc showCustomLoading(
      {required ToastBuilder toastBuilder,
      OptionFunc<CustomLoadingOption>? option}) {
    CustomLoadingOption o = CustomLoadingOption.defaultFunc();
    option?.call(o);

    return BotToast.showCustomLoading(
      toastBuilder: toastBuilder,
      wrapAnimation: o.wrapAnimation,
      wrapToastAnimation: o.wrapToastAnimation,
      align: o.align,
      backButtonBehavior: o.backButtonBehavior,
      clickClose: o.clickClose,
      allowClick: o.allowClick,
      ignoreContentClick: o.ignoreContentClick,
      crossPage: o.crossPage,
      enableKeyboardSafeArea: o.enableKeyboardSafeArea,
      onClose: o.onClose,
      duration: o.duration,
      animationDuration: o.animationDuration,
      animationReverseDuration: o.animationReverseDuration,
      backgroundColor: o.backgroundColor,
      useSafeArea: o.useSafeArea,
    );
  }

  static void closeAllLoading() {
    //以此方式移除将不会触发关闭动画
    BotToast.closeAllLoading();
  }

  static CancelFunc showAttachedWidget(
      {required ToastBuilder attachedBuilder,
      BuildContext? targetContext,
      Offset? target,
      OptionFunc<AttachedOption>? option}) {
    AttachedOption o = AttachedOption.defaultFunc();
    option?.call(o);

    return BotToast.showAttachedWidget(
      attachedBuilder: attachedBuilder,
      targetContext: targetContext,
      target: target,
      animationDuration: o.animationDuration,
      verticalOffset: o.verticalOffset,
      horizontalOffset: o.horizontalOffset,
      animationReverseDuration: o.animationReverseDuration,
      wrapAnimation: o.wrapAnimation,
      wrapToastAnimation: o.wrapToastAnimation,
      allowClick: o.allowClick,
      ignoreContentClick: o.ignoreContentClick,
      onlyOne: o.onlyOne,
      enableKeyboardSafeArea: o.enableKeyboardSafeArea,
      onClose: o.onClose,
      backgroundColor: o.backgroundColor,
      duration: o.duration,
      enableSafeArea: o.enableSafeArea,
      preferDirection: o.preferDirection,
    );
  }

  static CancelFunc showAnimationWidget(
      {required ToastBuilder toastBuilder,
      required Duration animationDuration,
      OptionFunc<AnimationOption>? option}) {
    AnimationOption o = AnimationOption.defaultFunc();
    option?.call(o);
    return BotToast.showAnimationWidget(
      toastBuilder: toastBuilder,
      animationDuration: animationDuration,
      animationReverseDuration: o.animationReverseDuration,
      wrapAnimation: o.wrapAnimation,
      wrapToastAnimation: o.wrapToastAnimation,
      key: o.key,
      groupKey: o.groupKey,
      crossPage: o.crossPage,
      allowClick: o.allowClick,
      clickClose: o.clickClose,
      ignoreContentClick: o.ignoreContentClick,
      onlyOne: o.onlyOne,
      enableKeyboardSafeArea: o.enableKeyboardSafeArea,
      backButtonBehavior: o.backButtonBehavior,
      onClose: o.onClose,
      backgroundColor: o.backgroundColor,
      duration: o.duration,
    );
  }

  static CancelFunc showEnhancedWidget(
      {required ToastBuilder toastBuilder,
      OptionFunc<EnhancedOption>? option}) {
    EnhancedOption o = EnhancedOption.defaultFunc();
    option?.call(o);

    return BotToast.showEnhancedWidget(
      toastBuilder: toastBuilder,
      key: o.key,
      groupKey: o.groupKey,
      crossPage: o.crossPage,
      allowClick: o.allowClick,
      clickClose: o.clickClose,
      ignoreContentClick: o.ignoreContentClick,
      onlyOne: o.onlyOne,
      enableKeyboardSafeArea: o.enableKeyboardSafeArea,
      backButtonBehavior: o.backButtonBehavior,
      closeFunc: o.closeFunc,
      onClose: o.onClose,
      backgroundColor: o.backgroundColor,
      warpWidget: o.warpWidget,
      duration: o.duration,
    );
  }

  static CancelFunc showWidget(
      {required ToastBuilder toastBuilder, UniqueKey? key, String? groupKey}) {
    return BotToast.showWidget(
        toastBuilder: toastBuilder, key: key, groupKey: groupKey);
  }

  static void remove(UniqueKey key, [String? groupKey]) {
    return BotToast.remove(key, groupKey);
  }

  static void removeAll([String? groupKey]) {
    BotToast.removeAll(groupKey);
  }

  static void cleanAll() {
    BotToast.cleanAll();
  }
}
