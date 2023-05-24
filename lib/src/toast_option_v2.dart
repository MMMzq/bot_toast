import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'basis.dart';
import 'toast_widget/animation.dart';

class Option<T> {
  final T v;

  Option(this.v);
}

typedef OptionFunc<T> = void Function(T);
typedef DefaultOptionFunc<T> = T Function();

class NotificationOption {
  static DefaultOptionFunc<NotificationOption> defaultFunc = () {
    return NotificationOption._();
  };

  static void modifyDefaultOption(OptionFunc<NotificationOption> f) {
    NotificationOption o = defaultFunc();
    f(o);
    defaultFunc = () => o;
  }

  NotificationOption._();

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
  VoidCallback? onClose;
  bool enableKeyboardSafeArea = true;
  bool enableSlideOff = true;
  bool crossPage = true;
  bool onlyOne = true;
}

class CustomNotificationOption {
  static DefaultOptionFunc<CustomNotificationOption> defaultFunc = () {
    return CustomNotificationOption._();
  };

  static void modifyDefaultOption(OptionFunc<CustomNotificationOption> f) {
    CustomNotificationOption o = defaultFunc();
    f(o);
    defaultFunc = () => o;
  }

  CustomNotificationOption._();

  WrapAnimation? wrapAnimation;
  WrapAnimation? wrapToastAnimation = notificationAnimation;
  Alignment? align = const Alignment(0, -0.99);
  List<DismissDirection> dismissDirections = const [
    DismissDirection.horizontal,
    DismissDirection.up
  ];
  Duration? duration = const Duration(seconds: 2);
  Duration? animationDuration;
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
  static DefaultOptionFunc<TextOption> defaultFunc = () {
    return TextOption._();
  };

  static void modifyDefaultOption(OptionFunc<TextOption> f) {
    TextOption o = defaultFunc();
    f(o);
    defaultFunc = () => o;
  }

  TextOption._();

  WrapAnimation? wrapAnimation;
  WrapAnimation? wrapToastAnimation = textAnimation;
  Color backgroundColor = Colors.transparent;
  Color contentColor = Colors.black54;
  BorderRadiusGeometry borderRadius =
      const BorderRadius.all(Radius.circular(8));
  TextStyle textStyle = const TextStyle(fontSize: 17, color: Colors.white);
  AlignmentGeometry? align = const Alignment(0, 0.8);
  EdgeInsetsGeometry contentPadding =
      const EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7);
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
  static DefaultOptionFunc<CustomTextOption> defaultFunc = () {
    return CustomTextOption._();
  };

  static void modifyDefaultOption(OptionFunc<CustomTextOption> f) {
    CustomTextOption o = defaultFunc();
    f(o);
    defaultFunc = () => o;
  }

  CustomTextOption._();

  WrapAnimation? wrapAnimation;
  WrapAnimation? wrapToastAnimation = textAnimation;
  AlignmentGeometry? align = const Alignment(0, 0.8);
  Color backgroundColor = Colors.transparent;
  Duration? duration = const Duration(seconds: 2);
  Duration? animationDuration;
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
  static DefaultOptionFunc<LoadingOption> defaultFunc = () {
    return LoadingOption._();
  };

  static void modifyDefaultOption(OptionFunc<LoadingOption> f) {
    LoadingOption o = defaultFunc();
    f(o);
    defaultFunc = () => o;
  }

  LoadingOption._();

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
  static DefaultOptionFunc<CustomLoadingOption> defaultFunc = () {
    return CustomLoadingOption._();
  };

  static void modifyDefaultOption(OptionFunc<CustomLoadingOption> f) {
    CustomLoadingOption o = defaultFunc();
    f(o);
    defaultFunc = () => o;
  }

  CustomLoadingOption._();

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
  Duration? animationDuration;
  Duration? animationReverseDuration;
  Color backgroundColor = Colors.black26;
  bool useSafeArea = true;
}

class AttachedOption {
  static DefaultOptionFunc<AttachedOption> defaultFunc = () {
    return AttachedOption._();
  };

  static void modifyDefaultOption(OptionFunc<AttachedOption> f) {
    AttachedOption o = defaultFunc();
    f(o);
    defaultFunc = () => o;
  }

  AttachedOption._();

  WrapAnimation? wrapAnimation;
  WrapAnimation? wrapToastAnimation = attachedAnimation;
  Color backgroundColor = Colors.transparent;
  double verticalOffset = 0.0;
  double horizontalOffset = 0.0;
  Duration? duration;
  Duration? animationDuration;
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
  static DefaultOptionFunc<AnimationOption> defaultFunc = () {
    return AnimationOption._();
  };

  static void modifyDefaultOption(OptionFunc<AnimationOption> f) {
    AnimationOption o = defaultFunc();
    f(o);
    defaultFunc = () => o;
  }

  AnimationOption._();

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
  static DefaultOptionFunc<EnhancedOption> defaultFunc = () {
    return EnhancedOption();
  };

  static void modifyDefaultOption(OptionFunc<EnhancedOption> f) {
    EnhancedOption o = defaultFunc();
    f(o);
    defaultFunc = () => o;
  }

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
