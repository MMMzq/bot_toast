import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

Widget notificationAnimation(
        AnimationController controller, CancelFunc cancelFunc, Widget child) =>
    NormalAnimation(reverse: true, controller: controller, child: child);

Widget textAnimation(
        AnimationController controller, CancelFunc cancelFunc, Widget child) =>
    NormalAnimation(controller: controller, child: child);

Widget loadingAnimation(
        AnimationController controller, CancelFunc cancelFunc, Widget child) =>
    FadeAnimation(controller: controller, child: child);

Widget attachedAnimation(
        AnimationController controller, CancelFunc cancelFunc, Widget child) =>
    FadeAnimation(controller: controller, child: child);

class NormalAnimation extends StatefulWidget {
  final Widget child;
  final bool reverse;
  final AnimationController controller;

  const NormalAnimation(
      {Key? key,
      required this.child,
      this.reverse = false,
      required this.controller})
      : super(key: key);

  @override
  NormalAnimationState createState() => NormalAnimationState();
}

class NormalAnimationState extends State<NormalAnimation>
    with SingleTickerProviderStateMixin {
  static final Tween<Offset> reverseTweenOffset = Tween<Offset>(
    begin: const Offset(0, -40),
    end: const Offset(0, 0),
  );
  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: const Offset(0, 40),
    end: const Offset(0, 0),
  );
  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  late final Animation<double> animation;

  late final Animation<Offset> animationOffset;
  late final Animation<double> animationOpacity;

  @override
  void initState() {
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);

    animationOffset =
        (widget.reverse ? reverseTweenOffset : tweenOffset).animate(animation);
    animationOpacity = tweenOpacity.animate(animation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, child) {
        return Transform.translate(
          offset: animationOffset.value,
          child: Opacity(
            opacity: animationOpacity.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

//淡出淡入动画
class FadeAnimation extends StatefulWidget {
  final Widget? child;
  final AnimationController controller;

  const FadeAnimation({Key? key, this.child, required this.controller})
      : super(key: key);

  @override
  FadeAnimationState createState() => FadeAnimationState();
}

class FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  late final Animation<double> animation;
  late final Animation<double> animationOpacity;

  @override
  void initState() {
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);

    animationOpacity = tweenOpacity.animate(animation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationOpacity,
      child: widget.child,
    );
  }
}
