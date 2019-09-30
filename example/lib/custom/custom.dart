import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class CustomAnimation extends StatefulWidget {
  @override
  _CustomAnimationState createState() => _CustomAnimationState();
}

class CustomAnimationWidget extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const CustomAnimationWidget({Key key, this.controller, this.child})
      : super(key: key);

  @override
  _CustomAnimationWidgetState createState() => _CustomAnimationWidgetState();
}

class _CustomAnimationWidgetState extends State<CustomAnimationWidget> {
  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: const Offset(0, 40),
    end: const Offset(0, 0),
  );

  static final Tween<double> tweenScale = Tween<double>(begin: 0.7, end: 1.0);
  Animation<double> animation;

  @override
  void initState() {
    widget.controller.forward();
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return Transform.translate(
          offset: tweenOffset.evaluate(animation),
          child: Transform.scale(
            scale: tweenScale.evaluate(animation),
            child: child,
          ),
        );
      },
    );
  }
}

class CustomLoadingAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const CustomLoadingAnimation({Key key, this.controller, this.child})
      : super(key: key);

  @override
  _CustomLoadingAnimationState createState() => _CustomLoadingAnimationState();
}

class _CustomLoadingAnimationState extends State<CustomLoadingAnimation> {
  static Tween<Offset> tweenOffset = Tween<Offset>(
    begin: const Offset(0.8, 0.0),
    end: Offset.zero,
  );
  Animation<double> animation;

  @override
  void initState() {
    widget.controller.forward();
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: widget.controller,
      builder: (BuildContext context, Widget child) {
        return FractionalTranslation(
            translation: tweenOffset.evaluate(animation),
            child: Opacity(
              opacity: animation.value,
              child: child,
            ));
      },
    );
  }
}

class _CustomAnimationState extends State<CustomAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomAnimation'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  BotToast.showAttachedWidget(
                      attachedBuilder: (_) => Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                      customToastAnimation: (controller, Widget child) =>
                          CustomAnimationWidget(
                            controller: controller,
                            child: child,
                          ),
                      enableSafeArea: false,
                      duration: Duration(seconds: 2),
                      target: Offset(200, 300));
                },
                child: const Text('customAttachedAnimation'),
              ),
              RaisedButton(
                onPressed: () {
                  BotToast.showText(
                    text: 'this is custom animation ',
                    customToastAnimation: (controller, Widget child) =>
                        CustomAnimationWidget(
                      controller: controller,
                      child: child,
                    ),
                  );
                },
                child: const Text('customTextAnimation'),
              ),
              RaisedButton(
                onPressed: () {
                  BotToast.showLoading(
                      animationDuration: Duration(milliseconds: 200),
                      duration: Duration(seconds: 2),
                      customAnimation: (controller, child) =>
                          CustomLoadingAnimation(
                              controller: controller, child: child));
                },
                child: const Text('customLoadingAnimation'),
              ),
              Divider(),
              Text("code"),
              Divider(),
//              Text(
//                _code,
//                textAlign: TextAlign.start,
//              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
