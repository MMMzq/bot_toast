import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void showAlertDialog(BackButtonBehavior backButtonBehavior,
    {VoidCallback? cancel,
    VoidCallback? confirm,
    VoidCallback? backgroundReturn}) {
  BotToast.showAnimationWidget(
      clickClose: false,
      allowClick: false,
      onlyOne: true,
      crossPage: true,
      backButtonBehavior: backButtonBehavior,
      wrapToastAnimation: (controller, cancel, child) => Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  cancel();
                  backgroundReturn?.call();
                },
                //The DecoratedBox here is very important,he will fill the entire parent component
                child: AnimatedBuilder(
                  builder: (_, child) => Opacity(
                    opacity: controller.value,
                    child: child,
                  ),
                  child: const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.black26),
                    child: SizedBox.expand(),
                  ),
                  animation: controller,
                ),
              ),
              CustomOffsetAnimation(
                controller: controller,
                child: child,
              )
            ],
          ),
      toastBuilder: (cancelFunc) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: const Text('this is custom widget'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  cancelFunc();
                  cancel?.call();
                },
                child: const Text(
                  'cancel',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
              TextButton(
                onPressed: () {
                  cancelFunc();
                  confirm?.call();
                },
                child: const Text('confirm'),
              ),
            ],
          ),
      animationDuration: const Duration(milliseconds: 300));
}

class CustomWidget extends StatefulWidget {
  @override
  _CustomWidgetState createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  BackButtonBehavior backButtonBehavior = BackButtonBehavior.none;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CustomWidget'),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  showAlertDialog(backButtonBehavior, cancel: () {
                    BotToast.showText(text: 'Click cancel');
                  }, confirm: () {
                    BotToast.showText(text: 'Click confirm');
                  }, backgroundReturn: () {
                    BotToast.showText(text: 'Click background');
                  });
                },
                child: const Text('customWidget'),
              ),
              const Center(
                child: Text('BackButtonBehavior'),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RadioListTile(
                      value: BackButtonBehavior.none,
                      groupValue: backButtonBehavior,
                      onChanged: (BackButtonBehavior? value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('none'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: BackButtonBehavior.ignore,
                      groupValue: backButtonBehavior,
                      onChanged: (BackButtonBehavior? value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('ignore'),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile(
                      value: BackButtonBehavior.close,
                      groupValue: backButtonBehavior,
                      onChanged: (BackButtonBehavior? value) {
                        setState(() {
                          backButtonBehavior = value!;
                        });
                      },
                      title: const Text('close'),
                    ),
                  )
                ],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomOffsetAnimation extends StatefulWidget {
  final AnimationController controller;
  final Widget child;

  const CustomOffsetAnimation({Key? key,required this.controller,required this.child})
      : super(key: key);

  @override
  _CustomOffsetAnimationState createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<CustomOffsetAnimation> {
  late Tween<Offset> tweenOffset;
  late Tween<double> tweenScale;

  late Animation<double> animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.8),
      end: Offset.zero,
    );
    tweenScale = Tween<double>(begin: 0.3, end: 1.0);
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      child: widget.child,
      animation: widget.controller,
      builder: (BuildContext context, Widget? child) {
        return FractionalTranslation(
            translation: tweenOffset.evaluate(animation),
            child: ClipRect(
              child: Transform.scale(
                scale: tweenScale.evaluate(animation),
                child: Opacity(
                  child: child,
                  opacity: animation.value,
                ),
              ),
            ));
      },
    );
  }
}
