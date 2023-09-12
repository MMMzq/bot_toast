### 🐹Main Api Documents

#### Area Map

```
  _________________________________
|          MainContent            |
|                                 |
|                                 |
|      ___________________        |
|     |                   |       |
|     |    ToastContent   |       |
|     |___________________|       |
|_________________________________|
```


**Calling BotToast.showXxx will always return a CancelFunc function, and invoking this function will prematurely close the corresponding Toast.**

#### General Parameter Explanation
Parameter | Description
---- | --- 
toastBuilder | Function that generates the Widget to be displayed (```typedef ToastBuilder = Widget Function(CancelFunc cancelFunc);```)
CancelFunc | Invoking BotToast.showXxx will always return this function, and calling this method will close the corresponding Toast in advance.
key | Represents a credential for this Toast; with this key, you can remove the Widget defined by the current key.
groupKey | Represents the key of the group to which this Toast belongs.
duration | Duration of display; if null, it will not be automatically timed to close; if not null, it will automatically close at the specified time.
crossPage | Whether to display across pages; if true, this Toast will span multiple Routes; if false, it will automatically close when the current Route changes, such as [Navigator.push] - [Navigator.pop], etc.
allowClick | Whether normal click events can be triggered while this Toast is displayed.
clickClose | Whether to automatically close this Toast when clicking on the screen to trigger an event.
ignoreContentClick | Whether to ignore the ToastContext area; if true, when the user clicks the ToastContext area, the click events can reach the Page normally, in other words, it is transparent (even if the Toast background color is not transparent); if false, it is the opposite.
onlyOne | Indicates whether only one Toast exists in the same group at the same time; the distinction between groups is based on [groupKey].
backgroundColor | Background color of the MainContent area.
backButtonBehavior | Behavior when clicking the physical back button (equivalent to the physical back button on Android); please note that this is not the back button on the navigation bar. If [BackButtonBehavior.ignore], it intercepts the back event; if [BackButtonBehavior.close], it closes the toast and intercepts the event to stop propagation; if null or [BackButtonBehavior.none], it does not intercept the event.

<br>


#### 1. BotToast.showSimpleNotification
##### Display a simple notification Toast

Parameter | Required | Default Value | Description
---- | --- | --- | ----
title | Yes | None | Title
subTitle | No | None | Subtitle
dismissDirections | No | `[horizontal, up]` | Directions in which sliding dismissal is allowed
animationDuration | No | `Duration(milliseconds: 256)` | [Refer to showAnimationWidget.animationDuration for details](#9bottoastshowanimationwidget)
animationReverseDuration | No | None | [Refer to showAnimationWidget.animationReverseDuration for details](#9bottoastshowanimationwidget)
wrapAnimation | No | None | [Refer to showAnimationWidget.wrapAnimation for details](#9bottoastshowanimationwidget)
wrapToastAnimation | No | `notificationAnimation` | [Refer to showAnimationWidget.wrapToastAnimation for details](#9bottoastshowanimationwidget)
align | No | `Alignment(0, -0.99)` | Alignment of the ToastContent area in the MainContent area
onTap | No | None | Callback when the notification Toast is tapped
onLongPress | No | None | Callback when the notification Toast is long-pressed
closeIcon | No | None | Icon for the close button
enableSlideOff | No | true | Whether sliding dismissal is enabled
hideCloseButton | No | false | Whether to hide the close button
duration | No | `Duration(seconds: 2)` | [Duration details](#General-Parameter-Explanation)
crossPage | No | true | [crossPage details](#General-Parameter-Explanation)
onlyOne | No | true | [onlyOne details](#General-Parameter-Explanation)
backButtonBehavior | No | None | [backButtonBehavior details](#General-Parameter-Explanation)
backgroundColor | No | `Theme.of(context).cardColor` | `Cards background color`
borderRadius | No | `ThemeData.cardTheme.shape` | `Cards border radius`
<br>


#### 2. BotToast.showNotification
##### Display a standard notification Toast

Parameter | Required | Default Value | Description
---- | --- | --- | ----
leading | No | None | Header
title | No | None | Title
subTitle | No | None | Subtitle
trailing | No | None | Footer
dismissDirections | No | `[horizontal, up]` | Directions in which sliding dismissal is allowed
animationDuration | No | `Duration(milliseconds: 256)` | [Refer to showAnimationWidget.animationDuration for details](#9bottoastshowanimationwidget)
animationReverseDuration | No | None | [Refer to showAnimationWidget.animationReverseDuration for details](#9bottoastshowanimationwidget)
wrapAnimation | No | None | [Refer to showAnimationWidget.wrapAnimation for details](#9bottoastshowanimationwidget)
wrapToastAnimation | No | `notificationAnimation` | [Refer to showAnimationWidget.wrapToastAnimation for details](#9bottoastshowanimationwidget)
align | No | `Alignment(0, -0.99)` | Alignment of the ToastContent area in the MainContent area
onTap | No | None | Callback when the notification Toast is tapped
onLongPress | No | None | Callback when the notification Toast is long-pressed
contentPadding | No | None | Padding of the ToastContent area
duration | No | `Duration(seconds: 2)` | [Duration details](#General-Parameter-Explanation)
crossPage | No | true | [crossPage details](#General-Parameter-Explanation)
onlyOne | No | true | [onlyOne details](#General-Parameter-Explanation)
enableSlideOff | No | true | Whether sliding dismissal is enabled
backButtonBehavior | No | None | [backButtonBehavior details](#General-Parameter-Explanation)
backgroundColor | No | `Theme.of(context).cardColor` | `Cards background color`
borderRadius | No | `ThemeData.cardTheme.shape` | `Cards border radius`

<br>

#### 3. BotToast.showCustomNotification
##### Display a custom notification Toast

Parameter | Required | Default Value | Description
---- | --- | --- | ----
toastBuilder | Yes | None | [toastBuilder details](#General-Parameter-Explanation)
dismissDirections | No | `[horizontal, up]` | Directions in which sliding dismissal is allowed
animationDuration | No | `Duration(milliseconds: 256)` | [Refer to showAnimationWidget.animationDuration for details](#9bottoastshowanimationwidget)
animationReverseDuration | No | None | [Refer to showAnimationWidget.animationReverseDuration for details](#9bottoastshowanimationwidget)
wrapAnimation | No | None | [Refer to showAnimationWidget.wrapAnimation for details](#9bottoastshowanimationwidget)
wrapToastAnimation | No | `notificationAnimation` | [Refer to showAnimationWidget.wrapToastAnimation for details](#9bottoastshowanimationwidget)
align | No | `Alignment(0, -0.99)` | Alignment of the ToastContent area in the MainContent area
enableSlideOff | No | true | Whether sliding dismissal is enabled
duration | No | `Duration(seconds: 2)` | [Duration details](#General-Parameter-Explanation)
crossPage | No | true | [crossPage details](#General-Parameter-Explanation)
onlyOne | No | true | [onlyOne details](#General-Parameter-Explanation)
backButtonBehavior | No | None | [backButtonBehavior details](#General-Parameter-Explanation)


<br>


#### 4. BotToast.showAttachedWidget
##### Display a positioned Toast, this method can be used to display around a specific Widget (usually a Button) or at a given offset.

Parameter | Required | Default Value | Description
---- | --- | --- | ----
attachedBuilder | Yes | None | [toastBuilder details](#General-Parameter-Explanation)
targetContext | No | None | Target Widget (usually a button), in most cases, it is wrapped with [Builder] to obtain the BuildContext ([target] and [targetContext] can only be chosen one)
target | No | None | Target [Offset], this offset is calculated with the screen's top-left corner as the origin ([target] and [targetContext] can only be chosen one)
animationDuration | No | `Duration(milliseconds: 150)` | [Refer to showAnimationWidget.animationDuration for details](#9bottoastshowanimationwidget)
animationReverseDuration | No | None | [Refer to showAnimationWidget.animationReverseDuration for details](#9bottoastshowanimationwidget)
wrapAnimation | No | None | [Refer to showAnimationWidget.wrapAnimation for details](#9bottoastshowanimationwidget)
wrapToastAnimation | No | `attachedAnimation` | [Refer to showAnimationWidget.wrapToastAnimation for details](#9bottoastshowanimationwidget)
preferDirection | No | None | Preferred direction; if space allows, it will tend to be displayed in that direction
verticalOffset | No | `0` | Vertical offset, this parameter is ineffective if the actual display direction is horizontally centered
horizontalOffset | No | `0` | Horizontal offset, this parameter is ineffective if the actual display direction is vertically centered
enableSafeArea | No | true | If true, the toast ensures that it does not appear above the app status bar (meaning it is safe), false otherwise
duration | No | None | [Duration details](#General-Parameter-Explanation)
onlyOne | No | false | [onlyOne details](#General-Parameter-Explanation)
allowClick | No | true | [allowClick details](#General-Parameter-Explanation)
ignoreContentClick | No | false | [ignoreContentClick details](#General-Parameter-Explanation)
backgroundColor | No | `Colors.transparent` | [backgroundColor details](#General-Parameter-Explanation)

<br>



#### 5. BotToast.showText
##### Display a standard text Toast

Parameter | Required | Default Value | Description
---- | --- | --- | ----
text | Yes | None | The text to be displayed
animationDuration | No | `Duration(milliseconds: 256)` | [Refer to showAnimationWidget.animationDuration for details](#9bottoastshowanimationwidget)
animationReverseDuration | No | None | [Refer to showAnimationWidget.animationReverseDuration for details](#9bottoastshowanimationwidget)
wrapAnimation | No | None | [Refer to showAnimationWidget.wrapAnimation for details](#9bottoastshowanimationwidget)
wrapToastAnimation | No | `textAnimation` | [Refer to showAnimationWidget.wrapToastAnimation for details](#9bottoastshowanimationwidget)
align | No | `Alignment(0, 0.8)` | Alignment of the ToastContent area in the MainContent area
contentColor | No | `Colors.black54` | Background color of the ToastContent area
borderRadius | No | `BorderRadius.all(Radius.circular(8))` | Border radius of the ToastContent area
textStyle | No | `TextStyle(fontSize: 17, color: Colors.white)` | Font style
contentPadding | No | `EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7)` | Padding of the ToastContent area
backgroundColor | No | `Colors.transparent` | [backgroundColor details](#General-Parameter-Explanation)
duration | No | `Duration(seconds: 2)` | [Duration details](#General-Parameter-Explanation)
onlyOne | No | true | [onlyOne details](#General-Parameter-Explanation)
crossPage | No | true | [crossPage details](#General-Parameter-Explanation)
clickClose | No | false | [clickClose details](#General-Parameter-Explanation)
backButtonBehavior | No | None | [backButtonBehavior details](#General-Parameter-Explanation)

<br>


#### 6. BotToast.showCustomText
##### Display a custom text Toast

Parameter | Required | Default Value | Description
---- | --- | --- | ----
toastBuilder | Yes | None | [toastBuilder details](#General-Parameter-Explanation)
animationDuration | No | `Duration(milliseconds: 256)` | [Refer to showAnimationWidget.animationDuration for details](#9bottoastshowanimationwidget)
animationReverseDuration | No | None | [Refer to showAnimationWidget.animationReverseDuration for details](#9bottoastshowanimationwidget)
wrapAnimation | No | None | [Refer to showAnimationWidget.wrapAnimation for details](#9bottoastshowanimationwidget)
wrapToastAnimation | No | `textAnimation` | [Refer to showAnimationWidget.wrapToastAnimation for details](#9bottoastshowanimationwidget)
align | No | `Alignment(0, 0.8)` | Alignment of the ToastContent area in the MainContent area
duration | No | `Duration(seconds: 2)` | [Duration details](#General-Parameter-Explanation)
crossPage | No | true | [crossPage details](#General-Parameter-Explanation)
onlyOne | No | false | [onlyOne details](#General-Parameter-Explanation)
clickClose | No | false | [clickClose details](#General-Parameter-Explanation)
ignoreContentClick | No | false | [ignoreContentClick details](#General-Parameter-Explanation)
backgroundColor | No | `Colors.transparent` | [backgroundColor details](#General-Parameter-Explanation)
backButtonBehavior | No | None | [backButtonBehavior details](#General-Parameter-Explanation)

<br>


#### 7. BotToast.showLoading
##### Display a standard loading Toast

Parameter | Required | Default Value | Description
---- | --- | --- | ----
animationDuration | No | `Duration(milliseconds: 300)` | [Refer to showAnimationWidget.animationDuration for details](#9bottoastshowanimationwidget)
animationReverseDuration | No | None | [Refer to showAnimationWidget.animationReverseDuration for details](#9bottoastshowanimationwidget)
wrapAnimation | No | `loadingAnimation` | [Refer to showAnimationWidget.wrapAnimation for details](#9bottoastshowanimationwidget)
wrapToastAnimation | No | None | [Refer to showAnimationWidget.wrapToastAnimation for details](#9bottoastshowanimationwidget)
align | No | `Alignment.center` | Alignment of the ToastContent area in the MainContent area
duration | No | None | [Duration details](#General-Parameter-Explanation)
crossPage | No | true | [crossPage details](#General-Parameter-Explanation)
clickClose | No | false | [clickClose details](#General-Parameter-Explanation)
allowClick | No | false | [allowClick details](#General-Parameter-Explanation)
backgroundColor | No | `Colors.black26` | [backgroundColor details](#General-Parameter-Explanation)
backButtonBehavior | No | None | [backButtonBehavior details](#General-Parameter-Explanation)

<br>



#### 8. BotToast.showCustomLoading
##### Display a custom loading Toast

Parameter | Required | Default Value | Description
---- | --- | --- | ----
toastBuilder | Yes | None | [toastBuilder details](#General-Parameter-Explanation)
animationDuration | No | `Duration(milliseconds: 300)` | [Refer to showAnimationWidget.animationDuration for details](#9bottoastshowanimationwidget)
animationReverseDuration | No | None | [Refer to showAnimationWidget.animationReverseDuration for details](#9bottoastshowanimationwidget)
wrapAnimation | No | `loadingAnimation` | [Refer to showAnimationWidget.wrapAnimation for details](#9bottoastshowanimationwidget)
wrapToastAnimation | No | None | [Refer to showAnimationWidget.wrapToastAnimation for details](#9bottoastshowanimationwidget)
align | No | `Alignment.center` | Alignment of the ToastContent area in the MainContent area
ignoreContentClick | No | false | [ignoreContentClick details](#General-Parameter-Explanation)
clickClose | No | false | [clickClose details](#General-Parameter-Explanation)
allowClick | No | false | [allowClick details](#General-Parameter-Explanation)
crossPage | No | false | [crossPage details](#General-Parameter-Explanation)
duration | No | None | [Duration details](#General-Parameter-Explanation)
backgroundColor | No | `Colors.black26` | [backgroundColor details](#General-Parameter-Explanation)
backButtonBehavior | No | None | [backButtonBehavior details](#General-Parameter-Explanation)

<br>


#### 9. BotToast.showAnimationWidget
##### Display a Toast that uses Animation

Parameter | Required | Default Value | Description
---- | --- | --- | ----
toastBuilder | Yes | None | [toastBuilder details](#General-Parameter-Explanation)
animationDuration | Yes | None | Duration of the forward animation, equivalent to [AnimationController.duration]. It is recommended not to exceed [duration].
animationReverseDuration | No | None | Duration of the reverse animation, equivalent to [AnimationController.reverseDuration].
wrapAnimation | No | None | Animation wrapping around the `MainContent` area, can be used for custom animations. If null, it means no animation is needed. Using this function does not necessarily mean using animation, it can also be used for additional wrapping of widgets. The biggest difference from `wrapToastAnimation` is the scope of processing.
wrapToastAnimation | No | None | Animation wrapping around the `ToastContent` area, can be used for custom animations. If null, it means no animation is needed. Using this function does not necessarily mean using animation, it can also be used for additional wrapping of widgets. The biggest difference from `wrapAnimation` is the scope of processing.
key | No | None | [Key details](#General-Parameter-Explanation)
groupKey | No | None | [groupKey details](#General-Parameter-Explanation)
ignoreContentClick | No | false | [ignoreContentClick details](#General-Parameter-Explanation)
clickClose | No | false | [clickClose details](#General-Parameter-Explanation)
onlyOne | No | false | [onlyOne details](#General-Parameter-Explanation)
allowClick | No | true | [allowClick details](#General-Parameter-Explanation)
crossPage | No | true | [Refer to showEnhancedWidget.crossPage](#10bottoastshowenhancedwidget)
closeFunc | No | None | [Refer to showEnhancedWidget.closeFunc](#10bottoastshowenhancedwidget)
warpWidget | No | None | [warpWidget details](#10bottoastshowenhancedwidget)
duration | No | None | [Duration details](#General-Parameter-Explanation)
backgroundColor | No | `Colors.transparent` | [backgroundColor details](#General-Parameter-Explanation)
backButtonBehavior | No | None | [backButtonBehavior details](#General-Parameter-Explanation)

<br>


#### 10. BotToast.showEnhancedWidget
##### Display an enhanced Toast, which allows the Toast to have many built-in features such as automatic timer-based closing, automatic closing on screen touch, and automatic closing when leaving the current Route, and more.

Parameter | Required | Default Value | Description
---- | --- | --- | ----
toastBuilder | Yes | None | [toastBuilder details](#General-Parameter-Explanation)
key | No | None | [Key details](#General-Parameter-Explanation)
groupKey | No | None | [groupKey details](#General-Parameter-Explanation)
ignoreContentClick | No | false | [ignoreContentClick details](#General-Parameter-Explanation)
clickClose | No | false | [clickClose details](#General-Parameter-Explanation)
onlyOne | No | false | [onlyOne details](#General-Parameter-Explanation)
allowClick | No | true | [allowClick details](#General-Parameter-Explanation)
crossPage | No | true | [crossPage details](#General-Parameter-Explanation)
closeFunc | No | None | The main purpose of this function parameter is to perform some actions before closing the Toast. For example, triggering [AnimationController] to start and wait for the animation to finish before closing.
warpWidget | No | None | A wrap function that can be used to wrap the MainContent area. For example, [showCustomLoading] wraps an animation to give the MainContent area animation.
duration | No | None | [Duration details](#General-Parameter-Explanation)
backgroundColor | No | `Colors.transparent` | [backgroundColor details](#General-Parameter-Explanation)
backButtonBehavior | No | None | [backButtonBehavior details](#General-Parameter-Explanation)

<br>


#### 11. BotToast.showWidget
##### Display a Widget on the screen. This Widget can exist across multiple pages.

Parameter | Required | Default Value | Description
---- | --- | --- | ----
toastBuilder | Yes | None | [toastBuilder details](#General-Parameter-Explanation)
key | No | None | [Key details](#General-Parameter-Explanation)
groupKey | No | None | [groupKey details](#General-Parameter-Explanation)
