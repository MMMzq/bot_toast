import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class CustomAnimation extends StatefulWidget {
  const CustomAnimation({Key? key}) : super(key: key);

  @override
  State<CustomAnimation> createState() => _CustomAnimationState();
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
                ElevatedButton(
                  onPressed: () {
                    BotToast.showLoading(
                        allowClick: true,
                        animationDuration: const Duration(milliseconds: 200),
                        duration: const Duration(seconds: 2),
                        wrapAnimation: (AnimationController controller, cancel, Widget child) =>
                            CustomOffsetAnimation(
                                controller: controller, child: child));
                  },
                  child: const Text('customLoadingAnimation'),
                ),
                ElevatedButton(
                  onPressed: () {
                    BotToast.showSimpleNotification(
                        animationDuration: const Duration(milliseconds: 200),
                        duration: const Duration(seconds: 2),
                        wrapToastAnimation: (AnimationController controller, cancel, Widget child) =>
                            CustomOffsetAnimation(
                                reverse: true,
                                controller: controller,
                                child: child),
                        title: 'customNotificationAnimation');
                  },
                  child: const Text('customNotificationAnimation'),
                ),
                ElevatedButton(
                  onPressed: () {
                    BotToast.showText(
                      text: 'this is custom animation ',
                      wrapToastAnimation: (AnimationController controller, cancel, Widget child) =>
                          CustomAnimationWidget(
                        controller: controller,
                        child: child,
                      ),
                    );
                  },
                  child: const Text('customTextAnimation'),
                ),
                Builder(
                  builder: (BuildContext context) => ElevatedButton(
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
                                      TextButton.icon(
                                        style:TextButton.styleFrom(
                                            padding: const EdgeInsets.all(5)),
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
                                        icon: const Icon(Icons.favorite,
                                            color: Colors.redAccent),
                                      ),
                                      TextButton.icon(
                                        style:TextButton.styleFrom(
                                            padding: const EdgeInsets.all(5)),
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
                                        icon: const Icon(Icons.bookmark,
                                            color: Colors.redAccent),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                          wrapToastAnimation:
                              (AnimationController controller, cancel, Widget child) =>
                                  CustomAttachedAnimation(
                                    controller: controller,
                                    child: child,
                                  ),
                          animationDuration: const Duration(milliseconds: 300),
                          enableSafeArea: false,
                          duration: const Duration(seconds: 2),
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

  const CustomAnimationWidget({required this.controller, required this.child, Key? key})
      : super(key: key);

  @override
  State<CustomAnimationWidget> createState() => _CustomAnimationWidgetState();
}

class _CustomAnimationWidgetState extends State<CustomAnimationWidget> {
  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: const Offset(0, 40),
    end: const Offset(0, 0),
  );

  static final Tween<double> tweenScale = Tween<double>(begin: 0.7, end: 1.0);
  late Animation<double> animation;

  @override
  void initState() {
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: tweenOffset.evaluate(animation),
          child: Transform.scale(
            scale: tweenScale.evaluate(animation),
            child: Opacity(
              opacity: animation.value,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;
  final bool reverse;

  const CustomOffsetAnimation(
      {required this.controller, required this.child, Key? key, this.reverse = false})
      : super(key: key);

  @override
  State<CustomOffsetAnimation> createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  late Tween<Offset> tweenOffset;

  late Animation<double> animation;

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
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
            translation: tweenOffset.evaluate(animation),
            child: Opacity(
              opacity: animation.value,
              child: child,
            ));
      },
      child: widget.child,
    );
  }
}

class CustomAttachedAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const CustomAttachedAnimation({required this.controller, required this.child, Key? key})
      : super(key: key);

  @override
  State<CustomAttachedAnimation> createState() =>
      _CustomAttachedAnimationState();
}

class _CustomAttachedAnimationState extends State<CustomAttachedAnimation> {
  late Animation<double> animation;
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
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
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
      child: widget.child,
    );
  }
}
