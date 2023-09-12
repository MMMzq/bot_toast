// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// ignore_for_file: prefer_const_constructors,always_specify_types,unused_local_variable

import 'package:bot_toast/bot_toast.dart';
import 'package:bot_toast/src/toast_widget/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future click(WidgetTester tester) async {
    await tester.tap(find.byKey(const ValueKey('main')));
    await tester.pump();
    await tester.pump();
    await tester.pump();
  }

  testWidgets('toast_navigator_observer ', (WidgetTester tester) async {
    int count = 0;
    await tester.pumpWidget(TestApp(
      contextCallback: (ctx) {
        Navigator.push(
            ctx,
            MaterialPageRoute(
                builder: (_) => Scaffold(
                      appBar: AppBar(),
                    )));
      },
    ));
    final proxy = BotToastNavigatorObserverProxy.all(() {
      count++;
    });
    BotToastNavigatorObserver.register(proxy);

    await click(tester);
    await tester.pump(const Duration(milliseconds: 2));
    await tester.pump();
    await tester.pageBack();

    expect(count, 2);

    BotToastNavigatorObserver.unregister(proxy);
  });

  testWidgets('textToast ', (WidgetTester tester) async {
    await tester.pumpWidget(TestApp(
      callback: () {
        BotToast.showText(
            text: 'testText', duration: Duration(milliseconds: 1));
      },
    ));
    await click(tester);

    expect(find.text('testText'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 2));
    await tester.pump();
    expect(find.text('testText'), findsNothing);
  });

  testWidgets('simpleNotification', (WidgetTester tester) async {
    await tester.pumpWidget(TestApp(
      callback: () {
        BotToast.showSimpleNotification(
            title: 'testText', duration: Duration(milliseconds: 1));
      },
    ));
    await click(tester);

    expect(find.text('testText'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 2));
    await tester.pump();
    expect(find.text('testText'), findsNothing);
  });

  testWidgets('customLoading', (WidgetTester tester) async {
    await tester.pumpWidget(TestApp(
      callback: () {
        BotToast.showCustomLoading(
            duration: Duration(milliseconds: 1),
            toastBuilder: (_) => Text('testText'));
      },
    ));

    await click(tester);

    expect(find.text('testText'), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 2));
    await tester.pump();
    expect(find.text('testText'), findsNothing);
  });

  group('attachedWidget', () {
    testWidgets('attachedWidget target', (WidgetTester tester) async {
      await tester.pumpWidget(TestApp(
        callback: () {
          BotToast.showAttachedWidget(
              target: Offset(0, 0),
              enableSafeArea: true,
              duration: Duration(milliseconds: 1),
              attachedBuilder: (_) => Text('testText'));
        },
      ));

      await click(tester);

      expect(find.text('testText'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 2));
      await tester.pump();
      expect(find.text('testText'), findsNothing);
    });

    testWidgets('attachedWidget targetContext', (WidgetTester tester) async {
      await tester.pumpWidget(TestApp(
        contextCallback: (ctx) {
          BotToast.showAttachedWidget(
              targetContext: ctx,
              duration: Duration(milliseconds: 1),
              attachedBuilder: (_) => Text('testText'));
        },
      ));
      await click(tester);

      expect(find.text('testText'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 2));
      await tester.pump();
      expect(find.text('testText'), findsNothing);
    });
  });

  group('animationWidget', () {
    testWidgets('animationWidget wrapAnimation', (WidgetTester tester) async {
      bool init = false;
      await tester.pumpWidget(TestApp(
        contextCallback: (ctx) async {
          BotToast.showAnimationWidget(
              duration: const Duration(milliseconds: 4),
              crossPage: false,
              wrapAnimation: (_, __, child) =>
                  ProxyInitState(
                    initStateCallback: () {
                      init = true;
                    },
                    child: child,
                  ),
              toastBuilder: (_) => Text('testText'),
              animationDuration: const Duration(milliseconds: 1));
        },
      ));

      await click(tester);
      expect(find.text('testText'), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 5));
      expect(init, isTrue);
    });

    testWidgets('animationWidget wrapToastAnimation',
            (WidgetTester tester) async {
          bool init = false;
          await tester.pumpWidget(TestApp(
            contextCallback: (ctx) async {
              BotToast.showAnimationWidget(
                  duration: const Duration(milliseconds: 4),
                  crossPage: false,
                  wrapToastAnimation: (_, __, child) =>
                      ProxyInitState(
                        initStateCallback: () {
                          init = true;
                        },
                        child: child,
                      ),
                  toastBuilder: (_) => Text('testText'),
                  animationDuration: const Duration(milliseconds: 1));
            },
          ));

          await click(tester);
          expect(find.text('testText'), findsOneWidget);

          await tester.pump(const Duration(milliseconds: 5));
          expect(init, isTrue);
        });
  });

  group('enhancedWidget', () {
    testWidgets('enhancedWidget crossPage=false', (WidgetTester tester) async {
      await tester.pumpWidget(TestApp(
        contextCallback: (ctx) async {
          Navigator.push(
              ctx,
              MaterialPageRoute(
                  builder: (_) =>
                      Scaffold(
                        appBar: AppBar(),
                      )));
          BotToast.showEnhancedWidget(
              duration: Duration(seconds: 999),
              crossPage: false,
              toastBuilder: (_) => Text('testText'));
        },
      ));
      await click(tester);
      expect(find.text('testText'), findsOneWidget);
      await tester.pageBack();
      await tester.pump();
      await tester.pump();
      expect(find.text('testText'), findsNothing);
    });

    testWidgets('enhancedWidget crossPage=true', (WidgetTester tester) async {
      await tester.pumpWidget(TestApp(
        contextCallback: (ctx) async {
          Navigator.push(
              ctx,
              MaterialPageRoute(
                  builder: (_) =>
                      Scaffold(
                        appBar: AppBar(),
                      )));
          BotToast.showEnhancedWidget(
              duration: Duration(seconds: 999),
              crossPage: true,
              toastBuilder: (_) => Text('testText'));
        },
      ));
      await click(tester);
      expect(find.text('testText'), findsOneWidget);
      await tester.pageBack();
      await tester.pump();
      await tester.pump();
      expect(find.text('testText'), findsOneWidget);
    });

    testWidgets('enhancedWidget clickClose', (WidgetTester tester) async {
      await tester.pumpWidget(TestApp(
        contextCallback: (ctx) async {
          BotToast.showEnhancedWidget(
              duration: Duration(seconds: 999),
              clickClose: true,
              toastBuilder: (_) => Text('testText'));
        },
        child: InkWell(
          key: ValueKey('test'),
          child: Text(''),
          onTap: () {},
        ),
      ));
      await click(tester);
      expect(find.text('testText'), findsOneWidget);
      await tester.tap(find.byKey(ValueKey('test')));
      await tester.pump();
      await tester.pump();
      expect(find.text('testText'), findsNothing);
    });

    testWidgets('enhancedWidget duration', (WidgetTester tester) async {
      await tester.pumpWidget(TestApp(
        contextCallback: (ctx) async {
          BotToast.showEnhancedWidget(
              duration: const Duration(milliseconds: 10),
              clickClose: true,
              toastBuilder: (_) => Text('testText'));
        },
      ));
      await click(tester);
      expect(find.text('testText'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 5));
      await tester.pump();
      expect(find.text('testText'), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 10));
      await tester.pump();
      expect(find.text('testText'), findsNothing);
    });

    testWidgets('enhancedWidget onlyOne', (WidgetTester tester) async {
      bool onlyOne = false;
      int i = 0;
      await tester.pumpWidget(TestApp(
        contextCallback: (ctx) async {
          i++;
          BotToast.showEnhancedWidget(
              duration: const Duration(milliseconds: 10),
              onlyOne: onlyOne,
              toastBuilder: (_) => const Text('testText'));
        },
      ));
      await click(tester);
      await click(tester);
      await click(tester);
      expect(find.text('testText'), findsNWidgets(3));
      onlyOne = true;
      await click(tester);
      expect(find.text('testText'), findsOneWidget);
    });

    testWidgets('enhancedWidget allowClick', (WidgetTester tester) async {
      bool allowClick = true;
      int i = 0;
      await tester.pumpWidget(TestApp(
          contextCallback: (ctx) async {
            BotToast.showEnhancedWidget(
                duration: Duration(seconds: 10),
                allowClick: allowClick,
                onlyOne: true,
                clickClose: false,
                toastBuilder: (_) => Text('testText'));
          },
          child: TextButton(
            key: ValueKey('test'),
            onPressed: () {
              i++;
            },
            child: Text(''),
          )));
      await click(tester);
      await tester.tap(find.byKey(ValueKey('test')));
      await tester.tap(find.byKey(ValueKey('test')));
      await tester.tap(find.byKey(ValueKey('test')));
      expect(i, 3);
      allowClick = false;
      await click(tester);
      await tester.tap(find.byKey(ValueKey('test')));
      await tester.tap(find.byKey(ValueKey('test')));
      await tester.tap(find.byKey(ValueKey('test')));
      expect(i, 3);
    });

    testWidgets('enhancedWidget ignoreContentClick',
            (WidgetTester tester) async {
          bool ignoreContentClick = false;
          int i = 0;
          await tester.pumpWidget(TestApp(contextCallback: (ctx) async {
            BotToast.showEnhancedWidget(
              duration: Duration(seconds: 10),
              ignoreContentClick: ignoreContentClick,
              onlyOne: true,
              clickClose: false,
              toastBuilder: (_) =>
                  Padding(
                    padding: EdgeInsets.all(100),
                    child: TextButton(
                      key: ValueKey('test'),
                      onPressed: () {
                        i++;
                      },
                      child: Text(''),
                    ),
                  ),
            );
          }));
          await click(tester);
          await tester.tap(find.byKey(ValueKey('test')));
          await tester.tap(find.byKey(ValueKey('test')));
          await tester.tap(find.byKey(ValueKey('test')));
          expect(i, 3);
          ignoreContentClick = true;
          await click(tester);
          expect(i, 3);
          await tester.tap(find.byKey(ValueKey('test')));
          await tester.tap(find.byKey(ValueKey('test')));
          await tester.tap(find.byKey(ValueKey('test')));
          expect(i, 3);
    });
  });
}

// ignore: must_be_immutable
class TestApp extends StatelessWidget {
  final VoidCallback? callback;
  final void Function(BuildContext ctx)? contextCallback;
  final Widget? child;

  TestApp({this.callback, this.child, this.contextCallback});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BotToast Demo',
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
                builder: (ctx) => TextButton(
                    key: const ValueKey('main'),
                    onPressed: () async {
                      callback?.call();
                      contextCallback?.call(ctx);
                    },
                    child: const Text(''))),
            if (child != null) child!
          ],
        ),
      ),
    );
  }
}
