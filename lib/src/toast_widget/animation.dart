//普通Toast进出动画
import 'package:flutter/material.dart';

class NormalAnimation extends StatefulWidget {
  final Widget child;
  final bool reverse;

  const NormalAnimation(
      {Key key, this.child, this.reverse = false})
      : assert(child != null),
        super(key: key);

  @override
  NormalAnimationState createState() => NormalAnimationState();
}

class NormalAnimationState extends State<NormalAnimation>
    with SingleTickerProviderStateMixin {
  static final Tween<Offset> reverseTweenOffset = Tween<Offset>(
    begin: Offset(0, -40),
    end: Offset(0, 0),
  );
  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: Offset(0, 40),
    end: Offset(0, 0),
  );
  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  AnimationController controller;
  Animation<double> animation;

  Animation<Offset> animationOffset;
  Animation<double> animationOpacity;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 256), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    animationOffset =
        (widget.reverse ? reverseTweenOffset : tweenOffset).animate(animation);
    animationOpacity = tweenOpacity.animate(animation);

    controller.forward();

    super.initState();
  }

  Future hide() {
    return controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
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
  final Widget child;
  final Duration duration;

  const FadeAnimation({Key key, this.child,this. duration}) : super(key: key);

  @override
  FadeAnimationState createState() => FadeAnimationState();
}

class FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  AnimationController controller;
  Animation<double> animation;
  Animation<double> animationOpacity;

  @override
  void initState() {
    controller =
        AnimationController(duration: widget.duration??Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    animationOpacity = tweenOpacity.animate(animation);

    controller.forward();

    super.initState();
  }

  Future hide() {
    return controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationOpacity,
      child: widget.child,
    );
  }
}


class SnackBarAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SnackBarAnimation({@required this.child,Key key, this.duration, }) :assert(child!=null), super(key: key);

  @override
  _SnackBarAnimationState createState() => _SnackBarAnimationState();
}

class _SnackBarAnimationState extends State<SnackBarAnimation> with SingleTickerProviderStateMixin {

  static const Curve _snackBarHeightCurve = Curves.fastOutSlowIn;
  static const Curve _snackBarFadeCurve = Interval(0.72, 1.0, curve: Curves.fastOutSlowIn);

  AnimationController controller ;

  CurvedAnimation heightAnimation ;
  CurvedAnimation fadeAnimation ;

  @override
  void initState() {
    controller =
        AnimationController(duration: widget.duration??Duration(seconds: 1), vsync: this);
    heightAnimation = CurvedAnimation(parent: controller, curve: _snackBarHeightCurve);
    fadeAnimation = CurvedAnimation(parent: controller, curve: _snackBarFadeCurve, reverseCurve: const Threshold(0.0));
    controller.forward();
    super.initState();
  }

  Future hide() {
    return controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Align(
            alignment: AlignmentDirectional.topStart,
            heightFactor: heightAnimation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
