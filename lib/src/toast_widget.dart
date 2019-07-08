part of 'toast.dart';

//普通Toast进出动画
class NormalAnimation extends StatefulWidget {
  final Widget child;
  final bool reverse;
  final void Function() disposeCallback;


  const NormalAnimation(
      {Key key, this.child, this.reverse = false, this.disposeCallback})
      :
        assert(child != null),
        super(key: key);

  @override
  NormalAnimationState createState() => NormalAnimationState();
}

class NormalAnimationState extends State<NormalAnimation> with SingleTickerProviderStateMixin{
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
    animation =
        CurvedAnimation(parent: controller, curve: Curves.decelerate);

    animationOffset = (widget.reverse ? reverseTweenOffset : tweenOffset)
        .animate(animation);
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
    widget.disposeCallback?.call();
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

  const _NotificationToast({Key key,@required this.child,@required this.slideOffFunc}) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<_NotificationToast> {

  @override
  Widget build(BuildContext context) {
    Widget child=widget.child;
    if(widget.slideOffFunc!=null){
      child=Dismissible(
        confirmDismiss: (_){
          widget.slideOffFunc();
        },
        child: child, key: UniqueKey(),
      );
    }

    return SafeArea(
      child: Align(
        alignment: Alignment(0,-0.99),
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

  const _TextToast({Key key, @required this.text, this.contentPadding, this.contentColor, this.borderRadius, this.textStyle, this.align}) : super(key: key);

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

//加载提示的Widget
class _LoadingWidget extends StatefulWidget {
  _LoadingWidget({Key key}) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<_LoadingWidget>
    with SingleTickerProviderStateMixin {
  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);

  AnimationController controller;
  Animation<double> animation;
  Animation<double> animationOpacity;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
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
      child: Scaffold(
        backgroundColor: Colors.black26,
        body: Center(
          child: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
