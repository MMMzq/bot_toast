part of 'toast.dart';

//文本提示的Widget
//大部分代码是是动画相关
class _TextToast extends StatefulWidget {
  final String text;

  const _TextToast({Key key, @required this.text}) : super(key: key);

  @override
  _TextToastState createState() => _TextToastState();
}

class _TextToastState extends State<_TextToast>
    with SingleTickerProviderStateMixin {
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
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    animationOffset = tweenOffset.animate(animation);
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
      child: Align(
        alignment: Alignment(0, 0.75),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
                constraints: constraints.copyWith(
                    maxWidth: constraints.biggest.width * 0.6),
                padding:
                    const EdgeInsets.only(left: 14,right: 14,top: 5,bottom: 9 ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Text(
                  widget.text,
                  style: TextStyle(fontSize: 17, color: Colors.white),
                  textAlign: TextAlign.center,
                ));
          },
        ),
      ),
    );
  }
}

//加载提示的Widget
//大部分代码是是动画相关
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
