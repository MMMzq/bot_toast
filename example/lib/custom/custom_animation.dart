import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

class CustomAnimation extends StatefulWidget {
  @override
  _CustomAnimationState createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomAnimation'),
      ),
      body: ButtonTheme.fromButtonThemeData(
        data: ButtonTheme.of(context).copyWith(minWidth: 250),
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    BotToast.showLoading(
                        allowClick: true,
                        animationDuration: Duration(milliseconds: 200),
                        duration: Duration(seconds: 2),
                        wrapAnimation: (controller, cancel, child) =>
                            CustomOffsetAnimation(
                                controller: controller, child: child));
                  },
                  child: const Text('customLoadingAnimation'),
                ),
                RaisedButton(
                  onPressed: () {
                    BotToast.showSimpleNotification(
                        animationDuration: Duration(milliseconds: 200),
                        duration: Duration(seconds: 2),
                        wrapToastAnimation: (controller, cancel, child) =>
                            CustomOffsetAnimation(
                                reverse: true,
                                controller: controller,
                                child: child),
                        title: 'customNotificationAnimation');
                  },
                  child: const Text('customNotificationAnimation'),
                ),
                RaisedButton(
                  onPressed: () {
                    BotToast.showText(
                      text: 'this is custom animation ',
                      wrapToastAnimation: (controller, cancel, Widget child) =>
                          CustomAnimationWidget(
                        controller: controller,
                        child: child,
                      ),
                    );
                  },
                  child: const Text('customTextAnimation'),
                ),
                Builder(
                  builder: (context) => RaisedButton(
                    onPressed: () {
                      BotToast.showAttachedWidget(
                          attachedBuilder: (_) => Card(
                                color: Colors.amber,
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      FlatButton.icon(
                                        padding: const EdgeInsets.all(5),
                                        onPressed: () {
                                          BotToast.showSimpleNotification(
                                              title:
                                                  "Let's go travel together.😘");
                                        },
                                        label: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              minWidth: 70),
                                          child: const Text('favorite'),
                                        ),
                                        icon: Icon(Icons.favorite,
                                            color: Colors.redAccent),
                                      ),
                                      FlatButton.icon(
                                        padding: const EdgeInsets.all(5),
                                        onPressed: () {
                                          BotToast.showSimpleNotification(
                                              title:
                                                  'Thank you for liking me.😝');
                                        },
                                        label: ConstrainedBox(
                                          constraints: const BoxConstraints(
                                              minWidth: 70),
                                          child: const Text('bookmark'),
                                        ),
                                        icon: Icon(Icons.bookmark,
                                            color: Colors.redAccent),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          wrapToastAnimation:
                              (controller, cancel, Widget child) =>
                                  CustomAttachedAnimation(
                                    controller: controller,
                                    child: child,
                                  ),
                          animationDuration: Duration(milliseconds: 300),
                          enableSafeArea: false,
                          duration: Duration(seconds: 2),
                          targetContext: context);
                    },
                    child: const Text('customAttachedAnimation'),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
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
            child: Opacity(
              child: child,
              opacity: animation.value,
            ),
          ),
        );
      },
    );
  }
}

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;
  final bool reverse;

  const CustomOffsetAnimation(
      {Key key, this.controller, this.child, this.reverse = false})
      : super(key: key);

  @override
  _CustomOffsetAnimationState createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  Tween<Offset> tweenOffset;

  Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: Offset(widget.reverse ? -0.8 : 0.8, 0.0),
      end: Offset.zero,
    );
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

class CustomAttachedAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const CustomAttachedAnimation({Key key, this.controller, this.child})
      : super(key: key);

  @override
  _CustomAttachedAnimationState createState() =>
      _CustomAttachedAnimationState();
}

class _CustomAttachedAnimationState extends State<CustomAttachedAnimation> {
  Animation<double> animation;
  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: const Offset(0, 40),
    end: const Offset(0, 0),
  );

  @override
  void initState() {
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
        return ClipRect(
          child: Align(
            heightFactor: animation.value,
            widthFactor: animation.value,
            child: Opacity(
              opacity: animation.value,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
