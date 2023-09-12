// ignore_for_file: prefer_const_constructors
// ignore_for_file: always_specify_types

import 'dart:collection';

import 'package:flutter/widgets.dart';

import 'basis.dart';

class _Object extends Object {
  const _Object() : super();
}

class _Icon extends Icon {
  const _Icon() : super(null);
}

class _Duration extends Duration {
  const _Duration() : super();
}

class _BackButtonBehavior extends BackButtonBehavior {
  const _BackButtonBehavior() : super(0, '');
}

class _PreferDirection extends PreferDirection {
  const _PreferDirection() : super(0, '');
}

class _TextStyle extends TextStyle {
  const _TextStyle() : super();
}

class _Color extends Color {
  const _Color() : super(0);
}

class _Alignment extends Alignment {
  const _Alignment() : super(0, 0);
}

class _EdgeInsets extends EdgeInsets {
  const _EdgeInsets() : super.all(0);
}

class _BorderRadius extends BorderRadius {
  const _BorderRadius() : super.only();
}

class _List<E> with ListBase<E> {
  const _List();

  @override
  operator [](int index) {
    throw UnimplementedError();
  }

  @override
  void operator []=(int index, value) {
    throw UnimplementedError();
  }

  @override
  int get length => throw UnimplementedError();

  @override
  set length(int newLength) {
    throw UnimplementedError();
  }
}

const _Object nil = _Object();
const _Icon nilIcon = _Icon();
const _Duration nilDuration = _Duration();
const _BackButtonBehavior nilBackButtonBehavior = _BackButtonBehavior();
const _PreferDirection nilPreferDirection = _PreferDirection();
const _TextStyle nilTextStyle = _TextStyle();
const _Color nilColor = _Color();
const _Alignment nilAlignment = _Alignment();
const _EdgeInsets nilEdgeInsets = _EdgeInsets();
const _BorderRadius nilBorderRadius = _BorderRadius();
const List<DismissDirection> nilDismissDirectionList = _List<DismissDirection>();

Widget nilWrapAnimation(AnimationController _, CancelFunc __, Widget ___) => const Placeholder();

Widget nilWrapWidget(CancelFunc __, Widget ___) => const Placeholder();

void nilVoidCallback() {}

Widget nilToastBuilder(CancelFunc cancelFunc) => const Placeholder();

Future<void> nilFutureFunc() async => {};

final Set<Object> nilSet = <Object>{
  nil,
  nilIcon,
  nilDuration,
  nilBackButtonBehavior,
  nilPreferDirection,
  nilTextStyle,
  nilColor,
  nilAlignment,
  nilDismissDirectionList,
  nilBorderRadius,
  nilEdgeInsets,
  nilWrapAnimation,
  nilWrapWidget,
  nilVoidCallback,
  nilToastBuilder,
  nilFutureFunc,
};

bool isNil(Object? o) {
  return nilSet.contains(o);
}

R returnFirstIfNotNil<R>(R v1, R v2) {
  if (!isNil(v1)) {
    return v1;
  } else {
    return v2;
  }
}

R returnFirstIfNotNilAndCast<R>(Object? v1, Object? v2) {
  if (!isNil(v1)) {
    return v1 as R;
  } else {
    return v2 as R;
  }
}

bool isNilOr<T>(List<Object?> list) {
  return list.any((element) => element != nil && !(list is T) && !(list is T?));
}
