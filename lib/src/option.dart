import 'package:flutter/material.dart';

import 'basis.dart';
import 'toast_widget/toast_widget.dart';

class Option {
  SimpleNotificationOption simpleNotification = SimpleNotificationOption();
  NotificationOption notification = NotificationOption();
  CustomNotificationOption customNotification = CustomNotificationOption();
  TextOption text = TextOption();
  CustomTextOption customText = CustomTextOption();
  LoadingOption loading = LoadingOption();
  CustomLoadingOption customLoading = CustomLoadingOption();
  AttachedOption attached = AttachedOption();
  AnimationOption animation = AnimationOption();
  EnhancedOption enhanced = EnhancedOption();
}

class SimpleNotificationOption {
  String? subTitle;

  TextStyle? titleStyle;

  TextStyle? subTitleStyle;

  WrapAnimation? wrapAnimation;

  WrapAnimation? wrapToastAnimation=notificationAnimation;

  GestureTapCallback? onTap;

  GestureLongPressCallback? onLongPress;

  Color? backgroundColor;

  double? borderRadius;

  Alignment? align = const Alignment(0, -0.99);

  List<DismissDirection> dismissDirections = [DismissDirection.horizontal, DismissDirection.up];

  Icon closeIcon = const Icon(Icons.cancel);

  Duration? duration = const Duration(seconds: 2);

  Duration? animationDuration;

  Duration? animationReverseDuration;

  BackButtonBehavior? backButtonBehavior;

  VoidCallback? onClose;

  bool enableKeyboardSafeArea = true;

  bool enableSlideOff = true;

  bool crossPage = false;

  bool onlyOne = true;

  bool hideCloseButton = true;
}

class NotificationOption {
  ToastBuilder? leading;
  ToastBuilder? title;
  ToastBuilder? subtitle;
  ToastBuilder? trailing;
  WrapAnimation? wrapAnimation;
  WrapAnimation? wrapToastAnimation = notificationAnimation;
  GestureTapCallback? onTap;
  Color? backgroundColor;
  double? borderRadius;
  GestureLongPressCallback? onLongPress;
  Alignment? align = const Alignment(0, -0.99);
  List<DismissDirection> dismissDirections = const [DismissDirection.horizontal, DismissDirection.up];
  BackButtonBehavior? backButtonBehavior;
  Duration? duration = const Duration(seconds: 2);
  Duration? animationDuration;
  Duration? animationReverseDuration;
  EdgeInsetsGeometry? contentPadding;
  EdgeInsetsGeometry? margin;
  VoidCallback? onClose;
  bool enableKeyboardSafeArea = true;
  bool enableSlideOff = true;
  bool crossPage = true;
  bool onlyOne = true;
}

class CustomNotificationOption {
  WrapAnimation? wrapAnimation;
  WrapAnimation? wrapToastAnimation = notificationAnimation;
  Alignment? align = const Alignment(0, -0.99);
  List<DismissDirection> dismissDirections = const [DismissDirection.horizontal, DismissDirection.up];
  Duration? duration = const Duration(seconds: 2);
  Duration animationDuration = const Duration(milliseconds: 256);
  Duration? animationReverseDuration;
  VoidCallback? onClose;
  BackButtonBehavior? backButtonBehavior;
  bool enableKeyboardSafeArea = true;
  bool enableSlideOff = true;
  bool crossPage = true;
  bool onlyOne = true;
  bool useSafeArea = true;
}

class TextOption {
  WrapAnimation? wrapAnimation;
  WrapAnimation? wrapToastAnimation = textAnimation;
  Color backgroundColor = Colors.transparent;
  Color contentColor = Colors.black54;
  BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(8));
  TextStyle textStyle = const TextStyle(fontSize: 17, color: Colors.white);
  AlignmentGeometry? align = const Alignment(0, 0.8);
  EdgeInsetsGeometry contentPadding = const EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7);
  Duration? duration = const Duration(seconds: 2);
  Duration? animationDuration;
  Duration? animationReverseDuration;
  BackButtonBehavior? backButtonBehavior;
  VoidCallback? onClose;
  bool enableKeyboardSafeArea = true;
  bool clickClose = false;
  bool crossPage = true;
  bool onlyOne = true;
}

class CustomTextOption {
  WrapAnimation? wrapAnimation;
  WrapAnimation? wrapToastAnimation = textAnimation;
  AlignmentGeometry? align = const Alignment(0, 0.8);
  Color backgroundColor = Colors.transparent;
  Duration? duration = const Duration(seconds: 2);
  Duration animationDuration = const Duration(milliseconds: 256);
  Duration? animationReverseDuration;
  VoidCallback? onClose;
  BackButtonBehavior? backButtonBehavior;
  bool enableKeyboardSafeArea = true;
  bool crossPage = true;
  bool clickClose = false;
  bool ignoreContentClick = false;
  bool onlyOne = false;
  bool useSafeArea = true;
}

class LoadingOption {
  WrapAnimation? wrapAnimation = loadingAnimation;
  WrapAnimation? wrapToastAnimation;
  Alignment align = Alignment.center;
  BackButtonBehavior? backButtonBehavior;
  bool crossPage = true;
  bool clickClose = false;
  bool allowClick = false;
  bool enableKeyboardSafeArea = true;
  VoidCallback? onClose;
  Duration? duration;
  Duration? animationDuration;
  Duration? animationReverseDuration;
  Color backgroundColor = Colors.black26;
}

class CustomLoadingOption {
  WrapAnimation? wrapAnimation = loadingAnimation;
  WrapAnimation? wrapToastAnimation;
  Alignment? align = Alignment.center;
  BackButtonBehavior? backButtonBehavior;
  bool clickClose = false;
  bool allowClick = false;
  bool ignoreContentClick = false;
  bool crossPage = false;
  bool enableKeyboardSafeArea = true;
  VoidCallback? onClose;
  Duration? duration;
  Duration animationDuration = const Duration(milliseconds: 300);
  Duration? animationReverseDuration;
  Color backgroundColor = Colors.black26;
  bool useSafeArea = true;
}

class AttachedOption {
  WrapAnimation? wrapAnimation;
  WrapAnimation? wrapToastAnimation = attachedAnimation;
  Color backgroundColor = Colors.transparent;
  double verticalOffset = 0.0;
  double horizontalOffset = 0.0;
  Duration? duration;
  Duration animationDuration = const Duration(milliseconds: 150);
  Duration? animationReverseDuration;
  PreferDirection? preferDirection;
  VoidCallback? onClose;
  bool ignoreContentClick = false;
  bool onlyOne = false;
  bool allowClick = true;
  bool enableKeyboardSafeArea = true;
  bool enableSafeArea = true;
}

class AnimationOption {
  Duration? animationReverseDuration;
  WrapAnimation? wrapAnimation;
  WrapAnimation? wrapToastAnimation;
  BackButtonBehavior? backButtonBehavior;
  UniqueKey? key;
  String? groupKey;
  bool crossPage = true;
  bool allowClick = true;
  bool clickClose = false;
  bool ignoreContentClick = false;
  bool onlyOne = false;
  bool enableKeyboardSafeArea = true;
  Color backgroundColor = Colors.transparent;
  Duration? duration;
  VoidCallback? onClose;
}

class EnhancedOption {
  UniqueKey? key;
  String? groupKey;
  bool crossPage = true;
  bool allowClick = true;
  bool clickClose = false;
  bool ignoreContentClick = false;
  bool onlyOne = false;
  bool enableKeyboardSafeArea = true;
  BackButtonBehavior? backButtonBehavior;
  FutureFunc? closeFunc;
  VoidCallback? onClose;
  Color backgroundColor = Colors.transparent;
  WrapWidget? warpWidget;
  Duration? duration;
}
