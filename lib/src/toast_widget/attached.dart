
import 'package:bot_toast/src/basis.dart';
import 'package:flutter/material.dart';

//定位Delegate
//使用该类默认是以Offset(0,app导航栏高度)为原点
class PositionDelegate extends SingleChildLayoutDelegate {
  PositionDelegate(
      {required this.target,
      required this.verticalOffset,
      required this.horizontalOffset,
      required this.paddingTop,
      this.enableSafeArea = true,
      PreferDirection? preferDirection})
      : this.preferDirection = preferDirection ?? PreferDirection.topCenter;

  final bool enableSafeArea;

  final Rect target;

  final double verticalOffset;
  final double horizontalOffset;
  final double paddingTop;

  final PreferDirection preferDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final double top = enableSafeArea ? paddingTop : 0;
    return positionToastBox(
      containerRect: Rect.fromLTWH(0, top, size.width, size.height - top),
      toastSize: childSize,
      targetRect: target,
      verticalOffset: verticalOffset,
      horizontalOffset: horizontalOffset,
      preferDirection: preferDirection,
    );
  }

  @override
  bool shouldRelayout(PositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        paddingTop != oldDelegate.paddingTop ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferDirection != oldDelegate.preferDirection;
  }
}

//当该方法推断出来的方向等于xxxCenter时
//则verticalOffset或者horizontalOffset失效
//例如:
//推断出来是topCent方向则horizontalOffset将会没效果,verticalOffset正常使用
Offset positionToastBox(
    {required Size toastSize,
    required Rect containerRect,
    required Rect targetRect,
    required PreferDirection preferDirection,
    double verticalOffset = 0.0,
    double horizontalOffset = 0.0}) {
  assert(verticalOffset >= 0, 'verticalOffset must be a positive number');
  assert(horizontalOffset >= 0, 'horizontalOffset must be a positive number');
  //裁剪
  if (containerRect.overlaps(targetRect)) {
    targetRect = targetRect.intersect(containerRect);
  } else {
    targetRect = Rect.fromLTWH(containerRect.left, containerRect.top, 0, 0);
  }

  bool canPlaceTop({double extraSpace = 0}) {
    return toastSize.height + verticalOffset < targetRect.top - containerRect.top + extraSpace;
  }

  bool canPlaceBottom({double extraSpace = 0}) {
    return toastSize.height + verticalOffset < containerRect.bottom - targetRect.bottom + extraSpace;
  }

  bool canPlaceLeft({double extraSpace = 0}) {
    return toastSize.width + horizontalOffset < targetRect.left - containerRect.left + extraSpace;
  }

  bool canPlaceRight({double extraSpace = 0}) {
    return toastSize.width + horizontalOffset < containerRect.right - targetRect.right + extraSpace;
  }

  String direction;
  //判断主方向,index由小到大
  if (preferDirection.index <= PreferDirection.topRight.index) {
    direction = canPlaceTop() ? "top" : "bottom";
  } else if (preferDirection.index <= PreferDirection.bottomRight.index) {
    direction = canPlaceBottom() ? "bottom" : "top";
  } else if (preferDirection.index <= PreferDirection.leftBottom.index) {
    direction = canPlaceLeft() ? "left" : "right";
  } else {
    direction = canPlaceRight() ? "right" : "left";
  }

  //判断对齐方向
  if (preferDirection.index <= PreferDirection.bottomRight.index) {
    switch (_getDirection(preferDirection).replaceAll("top", "").replaceAll("bottom", "")) {
      case "Left":
        direction += canPlaceRight(extraSpace: targetRect.width)
            ? "Left"
            : canPlaceLeft(extraSpace: targetRect.width)
                ? "Right"
                : "Center";
        break;
      case "Center":
        direction += "Center";
        break;
      case "Right":
        direction += canPlaceLeft(extraSpace: targetRect.width)
            ? "Right"
            : canPlaceRight(extraSpace: targetRect.width)
                ? "Left"
                : "Center";
        break;
    }
  } else {
    switch (_getDirection(preferDirection).replaceAll("left", "").replaceAll("right", "")) {
      case "Top":
        direction += canPlaceBottom(extraSpace: targetRect.height)
            ? "Top"
            : canPlaceTop(extraSpace: targetRect.height)
                ? "Bottom"
                : "Center";
        break;
      case "Center":
        direction += "Center";
        break;
      case "Bottom":
        direction += canPlaceTop(extraSpace: targetRect.height)
            ? "Bottom"
            : canPlaceBottom(extraSpace: targetRect.height)
                ? "Top"
                : "Center";
        break;
    }
  }

  Offset resultOffset = Offset.zero;
  switch (direction) {
    case "topLeft":
      resultOffset = targetRect.topLeft -
          Offset(0, toastSize.height) +
          Offset(
            horizontalOffset,
            -verticalOffset,
          );
      break;
    case "topCenter":
      bool rightOverflow = toastSize.width / 2 > containerRect.right - targetRect.topCenter.dx;
      bool leftOverflow = toastSize.width / 2 > targetRect.topCenter.dx - containerRect.left;
      if (rightOverflow && !leftOverflow) {
        resultOffset = Offset(containerRect.right - toastSize.width, targetRect.top - toastSize.height);
      } else if (leftOverflow && !rightOverflow) {
        resultOffset = Offset(containerRect.left, targetRect.top - toastSize.height);
      } else {
        resultOffset = targetRect.topCenter - Offset(toastSize.width / 2, toastSize.height);
      }
      resultOffset += Offset(0, -verticalOffset);
      break;
    case "topRight":
      resultOffset = targetRect.topRight -
          Offset(toastSize.width, toastSize.height) +
          Offset(
            -horizontalOffset,
            -verticalOffset,
          );
      break;
    case "bottomLeft":
      resultOffset = targetRect.bottomLeft + Offset(horizontalOffset, verticalOffset);
      break;
    case "bottomCenter":
      bool rightOverflow = toastSize.width / 2 > containerRect.right - targetRect.topCenter.dx;
      bool leftOverflow = toastSize.width / 2 > targetRect.topCenter.dx - containerRect.left;
      if (rightOverflow && !leftOverflow) {
        resultOffset = Offset(containerRect.right - toastSize.width, targetRect.bottom);
      } else if (leftOverflow && !rightOverflow) {
        resultOffset = Offset(containerRect.left, targetRect.bottom);
      } else {
        resultOffset = targetRect.bottomCenter - Offset(toastSize.width / 2, 0);
      }
      resultOffset += Offset(0, verticalOffset);
      break;
    case "bottomRight":
      resultOffset = targetRect.bottomRight - Offset(toastSize.width, 0) + Offset(-horizontalOffset, verticalOffset);
      break;
    case "leftTop":
      resultOffset = targetRect.topLeft - Offset(toastSize.width, 0) + Offset(-horizontalOffset, verticalOffset);
      break;
    case "leftCenter":
      bool topOverflow = toastSize.height / 2 > targetRect.centerLeft.dy - containerRect.top;
      bool bottomOverflow = toastSize.height / 2 > containerRect.bottom - targetRect.centerLeft.dy;
      if (topOverflow && !bottomOverflow) {
        resultOffset = Offset(
          targetRect.left - toastSize.width,
          containerRect.top,
        );
      } else if (bottomOverflow && !topOverflow) {
        resultOffset = Offset(
          targetRect.left - toastSize.width,
          containerRect.bottom - toastSize.height,
        );
      } else {
        resultOffset = targetRect.centerLeft - Offset(toastSize.width, toastSize.height / 2);
      }
      resultOffset += Offset(-horizontalOffset, 0);
      break;
    case "leftBottom":
      resultOffset = targetRect.bottomLeft - Offset(toastSize.width, toastSize.height) + Offset(-horizontalOffset, -verticalOffset);
      break;
    case "rightTop":
      resultOffset = targetRect.topRight + Offset(horizontalOffset, verticalOffset);
      break;
    case "rightCenter":
      bool topOverflow = toastSize.height / 2 > targetRect.centerLeft.dy - containerRect.top;
      bool bottomOverflow = toastSize.height / 2 > containerRect.bottom - targetRect.centerLeft.dy;
      if (topOverflow && !bottomOverflow) {
        resultOffset = Offset(
          targetRect.right,
          containerRect.top,
        );
      } else if (bottomOverflow && !topOverflow) {
        resultOffset = Offset(
          targetRect.right,
          containerRect.bottom - toastSize.height,
        );
      } else {
        resultOffset = targetRect.centerRight - Offset(0, toastSize.height / 2);
      }
      resultOffset += Offset(horizontalOffset, 0);
      break;
    case "rightBottom":
      resultOffset = targetRect.bottomRight - Offset(0, toastSize.height) + Offset(horizontalOffset, -verticalOffset);
      break;
  }

  return resultOffset;
}

String _getDirection(PreferDirection preferDirection) {
  return preferDirection.toString().replaceFirst("PreferDirection.", "");
}
