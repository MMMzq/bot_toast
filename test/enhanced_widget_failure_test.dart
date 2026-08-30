// Regression tests for the dangling `dismissFunc` problem.
//
// `showEnhancedWidget` registers `dismissFunc` with the duration timer, the
// navigator observer and the `onlyOne` cache *before* `cancelFunc` is assigned
// from `showWidget`. When `showWidget` throws — which happens in release builds
// whenever `BotToastManager` is not mounted, because the `botToastManager`
// getter falls through its debug-only assert into `_key.currentState!` — those
// registrations survive and later invoke a `cancelFunc` that was never
// assigned, producing an uncatchable `LateInitializationError`.

// ignore_for_file: always_specify_types

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // An app deliberately built *without* `BotToastInit()`, so `BotToastManager`
  // is never mounted and `showWidget` throws.
  Future<void> pumpAppWithoutInit(WidgetTester tester) {
    return tester.pumpWidget(MaterialApp(
      navigatorObservers: <NavigatorObserver>[BotToastNavigatorObserver()],
      home: const Scaffold(body: SizedBox.shrink()),
    ));
  }

  testWidgets('the duration timer is cancelled when showWidget fails',
      (WidgetTester tester) async {
    await pumpAppWithoutInit(tester);

    expect(
      () => BotToast.showEnhancedWidget(
        duration: const Duration(milliseconds: 10),
        toastBuilder: (_) => const Text('toast'),
      ),
      throwsA(isNotNull),
    );

    await tester.pump(const Duration(milliseconds: 20));
    expect(tester.takeException(), isNull);
  });

  testWidgets('the navigator observer proxy is unregistered when showWidget fails',
      (WidgetTester tester) async {
    await pumpAppWithoutInit(tester);
    final BuildContext context = tester.element(find.byType(Scaffold));

    expect(
      () => BotToast.showEnhancedWidget(
        duration: null,
        crossPage: false,
        toastBuilder: (_) => const Text('toast'),
      ),
      throwsA(isNotNull),
    );

    Navigator.push<void>(
        context, MaterialPageRoute<void>(builder: (_) => const Scaffold()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('a failed toast does not leak into the onlyOne cache',
      (WidgetTester tester) async {
    await pumpAppWithoutInit(tester);

    expect(
      () => BotToast.showEnhancedWidget(
        duration: null,
        crossPage: true,
        toastBuilder: (_) => const Text('toast'),
      ),
      throwsA(isNotNull),
    );

    // `onlyOne` closes every toast still held by the cache; a leaked entry
    // would invoke the dangling `dismissFunc` of the failed toast above.
    expect(
      () => BotToast.showEnhancedWidget(
        duration: null,
        crossPage: true,
        onlyOne: true,
        toastBuilder: (_) => const Text('toast'),
      ),
      throwsA(isNotNull),
    );

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('the animation controller is disposed when showWidget fails',
      (WidgetTester tester) async {
    // `showAnimationWidget` creates the controller before delegating, and the
    // only thing that disposes it is a `ProxyDispose` inside the toast — which
    // never mounts when the toast fails.
    expect(kFlutterMemoryAllocationsEnabled, isTrue,
        reason: 'this test relies on object lifecycle events');

    await pumpAppWithoutInit(tester);

    int created = 0;
    int disposed = 0;
    void onObjectEvent(ObjectEvent event) {
      if (event.object is! AnimationController) {
        return;
      }
      if (event is ObjectCreated) {
        created++;
      } else if (event is ObjectDisposed) {
        disposed++;
      }
    }

    FlutterMemoryAllocations.instance.addListener(onObjectEvent);
    addTearDown(
        () => FlutterMemoryAllocations.instance.removeListener(onObjectEvent));

    expect(
      () => BotToast.showAnimationWidget(
        duration: const Duration(milliseconds: 10),
        animationDuration: const Duration(milliseconds: 1),
        toastBuilder: (_) => const Text('toast'),
      ),
      throwsA(isNotNull),
    );

    expect(created, 1);
    expect(disposed, created);
  });
}
