part of 'toast.dart';

class ProxyDispose extends StatefulWidget {
  final Widget child;
  final VoidCallback disposeCallback;

  const ProxyDispose(
      {Key key, @required this.disposeCallback,@required this.child, })
      : assert(child != null),
        assert(disposeCallback != null),
        super(key: key);

  @override
  _ProxyDisposeState createState() => _ProxyDisposeState();
}

class _ProxyDisposeState extends State<ProxyDispose> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.disposeCallback();
    super.dispose();
  }
}

//普通Toast进出动画
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

//通知Toast的Widget
class _NotificationToast extends StatefulWidget {
  final Widget child;

  final Function slideOffFunc;

  const _NotificationToast(
      {Key key, @required this.child, @required this.slideOffFunc})
      : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<_NotificationToast> {
  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    if (widget.slideOffFunc != null) {
      child = Dismissible(
        confirmDismiss: (_) {
          widget.slideOffFunc();
        },
        child: child,
        key: UniqueKey(),
      );
    }

    return SafeArea(
      child: Align(
        alignment: Alignment(0, -0.99),
        child: child,
      ),
    );
  }
}

//文本提示的Widget
class _TextToast extends StatefulWidget {
  final String text;
  final EdgeInsetsGeometry contentPadding;
  final Color contentColor;
  final BorderRadiusGeometry borderRadius;
  final TextStyle textStyle;
  final AlignmentGeometry align;

  const _TextToast(
      {Key key,
      @required this.text,
      this.contentPadding,
      this.contentColor,
      this.borderRadius,
      this.textStyle,
      this.align})
      : super(key: key);

  @override
  _TextToastState createState() => _TextToastState();
}

class _TextToastState extends State<_TextToast> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.align,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              constraints: constraints.copyWith(
                  maxWidth: constraints.biggest.width * 0.6),
              padding: widget.contentPadding,
              decoration: BoxDecoration(
                color: widget.contentColor,
                borderRadius: widget.borderRadius,
              ),
              child: Text(
                widget.text,
                style: widget.textStyle,
                textAlign: TextAlign.center,
              ));
        },
      ),
    );
  }
}

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

//加载提示的Widget
class _LoadingWidget extends StatelessWidget {
  _LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class PositionDelegate extends SingleChildLayoutDelegate {
  PositionDelegate( {
    @required this.target,
    @required this.verticalOffset,
    PreferDirection preferDirection
  })  : assert(target != null),
        assert(verticalOffset != null),
        this.preferDirection = preferDirection ?? PreferDirection.Below;

  final Offset target;

  final double verticalOffset;

  final PreferDirection preferDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferDirection==PreferDirection.Below,
    );
  }

  @override
  bool shouldRelayout(PositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferDirection != oldDelegate.preferDirection;
  }
}
