// ignore_for_file: prefer_const_constructors
// ignore_for_file: always_specify_types

import 'dart:math';

import 'package:flutter/widgets.dart';

import 'basis.dart';

abstract class Nil {
  @override
  int get hashCode => identityHashCode(this);

  @override
  bool operator ==(Object other) {
    return other.runtimeType == runtimeType && other.hashCode == hashCode;
  }
}

class _Object extends Object with Nil {
  const _Object() : super();
}

class _Icon extends Icon with Nil {
  const _Icon() : super(null);
}

class _Duration extends Duration with Nil {
  const _Duration() : super();
}

class _BackButtonBehavior extends BackButtonBehavior with Nil {
  const _BackButtonBehavior() : super(0, '');
}

class _PreferDirection extends PreferDirection with Nil {
  const _PreferDirection() : super(0, '');
}

class _TextStyle extends TextStyle with Nil {
  const _TextStyle() : super();
}

class _Color extends Color with Nil {
  const _Color() : super(0);
}

class _Alignment extends Alignment with Nil {
  const _Alignment() : super(0, 0);
}

class _EdgeInsets extends EdgeInsets with Nil {
  const _EdgeInsets() : super.all(0);
}

class _BorderRadius extends BorderRadius with Nil {
  const _BorderRadius() : super.only();
}

class _List<E> with Nil implements List<E> {
  const _List();

  @override
  E get first => throw UnimplementedError();

  @override
  set first(E first) {
    throw UnimplementedError();
  }

  @override
  E get last => throw UnimplementedError();

  @override
  set last(E last) {
    throw UnimplementedError();
  }

  @override
  int get length => throw UnimplementedError();

  @override
  set length(int length) {
    throw UnimplementedError();
  }

  @override
  List<E> operator +(List<E> other) {
    throw UnimplementedError();
  }

  @override
  E operator [](int index) {
    throw UnimplementedError();
  }

  @override
  void operator []=(int index, E value) {}

  @override
  void add(E value) {}

  @override
  void addAll(Iterable<E> iterable) {}

  @override
  bool any(bool Function(E element) test) {
    throw UnimplementedError();
  }

  @override
  Map<int, E> asMap() {
    throw UnimplementedError();
  }

  @override
  List<R> cast<R>() {
    throw UnimplementedError();
  }

  @override
  void clear() {}

  @override
  bool contains(Object? element) {
    throw UnimplementedError();
  }

  @override
  E elementAt(int index) {
    throw UnimplementedError();
  }

  @override
  bool every(bool Function(E element) test) {
    throw UnimplementedError();
  }

  @override
  Iterable<T> expand<T>(Iterable<T> Function(E element) f) {
    throw UnimplementedError();
  }

  @override
  void fillRange(int start, int end, [E? fillValue]) {}

  @override
  E firstWhere(bool test(E element), {E orElse()?}) {
    throw UnimplementedError();
  }

  @override
  T fold<T>(T initialValue, T Function(T previousValue, E element) combine) {
    throw UnimplementedError();
  }

  @override
  Iterable<E> followedBy(Iterable<E> other) {
    throw UnimplementedError();
  }

  @override
  void forEach(void Function(E element) f) {}

  @override
  Iterable<E> getRange(int start, int end) {
    throw UnimplementedError();
  }

  @override
  int indexOf(E element, [int start = 0]) {
    throw UnimplementedError();
  }

  @override
  int indexWhere(bool Function(E element) test, [int start = 0]) {
    throw UnimplementedError();
  }

  @override
  void insert(int index, E element) {}

  @override
  void insertAll(int index, Iterable<E> iterable) {}

  @override
  bool get isEmpty => throw UnimplementedError();

  @override
  bool get isNotEmpty => throw UnimplementedError();

  @override
  Iterator<E> get iterator => throw UnimplementedError();

  @override
  String join([String separator = '']) {
    throw UnimplementedError();
  }

  @override
  int lastIndexOf(E element, [int? start]) {
    throw UnimplementedError();
  }

  @override
  int lastIndexWhere(bool Function(E element) test, [int? start]) {
    throw UnimplementedError();
  }

  @override
  E lastWhere(bool test(E element), {E orElse()?}) {
    throw UnimplementedError();
  }

  @override
  Iterable<T> map<T>(T Function(E e) f) {
    throw UnimplementedError();
  }

  @override
  E reduce(E Function(E value, E element) combine) {
    throw UnimplementedError();
  }

  @override
  bool remove(Object? value) {
    throw UnimplementedError();
  }

  @override
  E removeAt(int index) {
    throw UnimplementedError();
  }

  @override
  E removeLast() {
    throw UnimplementedError();
  }

  @override
  void removeRange(int start, int end) {}

  @override
  void removeWhere(bool Function(E element) test) {}

  @override
  void replaceRange(int start, int end, Iterable<E> replacement) {}

  @override
  void retainWhere(bool Function(E element) test) {}

  @override
  Iterable<E> get reversed => throw UnimplementedError();

  @override
  void setAll(int index, Iterable<E> iterable) {}

  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {}

  @override
  void shuffle([Random? random]) {}

  @override
  E get single => throw UnimplementedError();

  @override
  E singleWhere(bool test(E element), {E orElse()?}) {
    throw UnimplementedError();
  }

  @override
  Iterable<E> skip(int count) {
    throw UnimplementedError();
  }

  @override
  Iterable<E> skipWhile(bool Function(E value) test) {
    throw UnimplementedError();
  }

  @override
  void sort([int compare(E a, E b)?]) {}

  @override
  List<E> sublist(int start, [int? end]) {
    throw UnimplementedError();
  }

  @override
  Iterable<E> take(int count) {
    throw UnimplementedError();
  }

  @override
  Iterable<E> takeWhile(bool Function(E value) test) {
    throw UnimplementedError();
  }

  @override
  List<E> toList({bool growable = true}) {
    throw UnimplementedError();
  }

  @override
  Set<E> toSet() {
    throw UnimplementedError();
  }

  @override
  Iterable<E> where(bool Function(E element) test) {
    throw UnimplementedError();
  }

  @override
  Iterable<T> whereType<T>() {
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
const List<DismissDirection> nilDismissDirectionList = _List();

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
  return list.every((element) => isNil(element) || element is T || element is T?);
}
