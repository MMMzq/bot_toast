part of 'toast.dart';

class ProxyDispose extends StatefulWidget {
  final Widget child;
  final VoidCallback disposeCallback;

  const ProxyDispose(
      {Key key, @required this.disposeCallback,@required this.child, })
      : assert(child != null),
        assert(disposeCallback != null),
        super(key: key);

  @override
  _ProxyDisposeState createState() => _ProxyDisposeState();
}

class _ProxyDisposeState extends State<ProxyDispose> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.disposeCallback();
    super.dispose();
  }
}

//普通Toast进出动画
class NormalAnimation extends StatefulWidget {
  final Widget child;
  final bool reverse;

  const NormalAnimation(
      {Key key, this.child, this.reverse = false})
      : assert(child != null),
        super(key: key);

  @override
  NormalAnimationState createState() => NormalAnimationState();
}

class NormalAnimationState extends State<NormalAnimation>
    with SingleTickerProviderStateMixin {
  static final Tween<Offset> reverseTweenOffset = Tween<Offset>(
    begin: Offset(0, -40),
    end: Offset(0, 0),
  );
  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: Offset(0, 40),
    end: Offset(0, 0),
  );
  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  AnimationController controller;
  Animation<double> animation;

  Animation<Offset> animationOffset;
  Animation<double> animationOpacity;

  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(milliseconds: 256), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    animationOffset =
        (widget.reverse ? reverseTweenOffset : tweenOffset).animate(animation);
    animationOpacity = tweenOpacity.animate(animation);

    controller.forward();

    super.initState();
  }

  Future hide() {
    return controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, child) {
        return Transform.translate(
          offset: animationOffset.value,
          child: Opacity(
            opacity: animationOpacity.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

//通知Toast的Widget
class _NotificationToast extends StatefulWidget {
  final Widget child;

  final Function slideOffFunc;

  const _NotificationToast(
      {Key key, @required this.child, @required this.slideOffFunc})
      : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<_NotificationToast> {
  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    if (widget.slideOffFunc != null) {
      child = Dismissible(
        confirmDismiss: (_) {
          widget.slideOffFunc();
        },
        child: child,
        key: UniqueKey(),
      );
    }

    return SafeArea(
      child: Align(
        alignment: Alignment(0, -0.99),
        child: child,
      ),
    );
  }
}

//文本提示的Widget
class _TextToast extends StatefulWidget {
  final String text;
  final EdgeInsetsGeometry contentPadding;
  final Color contentColor;
  final BorderRadiusGeometry borderRadius;
  final TextStyle textStyle;
  final AlignmentGeometry align;

  const _TextToast(
      {Key key,
      @required this.text,
      this.contentPadding,
      this.contentColor,
      this.borderRadius,
      this.textStyle,
      this.align})
      : super(key: key);

  @override
  _TextToastState createState() => _TextToastState();
}

class _TextToastState extends State<_TextToast> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.align,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
              constraints: constraints.copyWith(
                  maxWidth: constraints.biggest.width * 0.6),
              padding: widget.contentPadding,
              decoration: BoxDecoration(
                color: widget.contentColor,
                borderRadius: widget.borderRadius,
              ),
              child: Text(
                widget.text,
                style: widget.textStyle,
                textAlign: TextAlign.center,
              ));
        },
      ),
    );
  }
}

//淡出淡入动画
class FadeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeAnimation({Key key, this.child,this. duration}) : super(key: key);

  @override
  FadeAnimationState createState() => FadeAnimationState();
}

class FadeAnimationState extends State<FadeAnimation>
    with SingleTickerProviderStateMixin {
  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  AnimationController controller;
  Animation<double> animation;
  Animation<double> animationOpacity;

  @override
  void initState() {
    controller =
        AnimationController(duration: widget.duration??Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    animationOpacity = tweenOpacity.animate(animation);

    controller.forward();

    super.initState();
  }

  Future hide() {
    return controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationOpacity,
      child: widget.child,
    );
  }
}

//加载提示的Widget
class _LoadingWidget extends StatelessWidget {
  _LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

//定位Delegate
//使用该类默认是以左上角来定位的也就是Offset(0,0)
class PositionDelegate extends SingleChildLayoutDelegate {
  PositionDelegate( {
    @required this.target,
     this.verticalOffset,
    this.horizontalOffset,
    PreferDirection preferDirection
  })  : assert(target != null),
        assert(verticalOffset != null),
        assert(horizontalOffset != null),
        this.preferDirection = preferDirection ?? PreferDirection.topCenter;

  final Rect target;

  final double verticalOffset;
  final double horizontalOffset;

  final PreferDirection preferDirection;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionToastBox(
      containerRect: Rect.fromLTWH(0, 0, size.width, size.height),
      toastSize: childSize,
      targetRect: target,
      verticalOffset: verticalOffset??0,
      horizontalOffset: horizontalOffset??0,
      preferDirection: preferDirection??PreferDirection.topCenter,
    );
  }

  @override
  bool shouldRelayout(PositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferDirection != oldDelegate.preferDirection;
  }
}


bool _containsOffset(Rect containerRect,Offset targetOffset){
  return targetOffset.dx >= containerRect.left && targetOffset.dx <= containerRect.right && targetOffset.dy >= containerRect.top && targetOffset.dy <= containerRect.bottom;
}

//当该方法推断出来的方向等于xxxCenter时
//则verticalOffset或者horizontalOffset失效
//例如:
//推断出来是topCent方向则horizontalOffset将会没效果,verticalOffset正常使用
Offset positionToastBox({
  @required Size toastSize,
  @required Rect containerRect,
  @required Rect targetRect,
  @required PreferDirection preferDirection,
  double verticalOffset = 0.0,double horizontalOffset=0.0}){
  assert(verticalOffset>=0,"verticalOffset必须为正数");
  assert(horizontalOffset>=0,"horizontalOffset必须为正数");
  assert(containerRect != null);
  assert(toastSize != null);
  assert(targetRect != null);
  assert(verticalOffset != null);
  assert(preferDirection != null);
  assert(_containsOffset(containerRect,targetRect.topLeft)&&_containsOffset(containerRect,targetRect.bottomRight),"containerRect 必须完全包含 targetRect");

  bool canPlaceTop({double extraSpace=0}){
    return toastSize.height+verticalOffset<targetRect.top-containerRect.top+extraSpace;
  }

  bool canPlaceBottom({double extraSpace=0}){
    return toastSize.height+verticalOffset<containerRect.bottom-targetRect.bottom+extraSpace;
  }

  bool canPlaceLeft({double extraSpace=0}){
    return toastSize.width+horizontalOffset<targetRect.left-containerRect.left+extraSpace;
  }
  bool canPlaceRight({double extraSpace=0}){
    return toastSize.width+horizontalOffset<containerRect.right-targetRect.right+extraSpace;
  }

  String inferHorizontalAlignDirection(){
    if(targetRect.center==containerRect.center) return "Center"; //完全居中时的特殊情况

    bool leftOverflow=targetRect.center.dx-containerRect.left<toastSize.width/2;
    bool rightOverflow=containerRect.right-targetRect.center.dx<toastSize.width/2;

    if(leftOverflow&&rightOverflow){
      return "Center";
    }else if(leftOverflow&&canPlaceRight(extraSpace: targetRect.width)){
      return "Left";
    }else if(rightOverflow&&canPlaceLeft(extraSpace: targetRect.width)){
      return "Right";
    }else{
      //这是都两边都溢出的情况,这是加了offset的情况
      return "Center";
    }
  }

  String inferVerticalAlignDirection(){
    if(targetRect.center==containerRect.center) return "Center"; //完全居中时的特殊情况

    bool topOverflow=targetRect.center.dy-containerRect.top<toastSize.height/2;
    bool bottomOverflow=containerRect.bottom-targetRect.center.dy<toastSize.height/2;

    if(topOverflow&&bottomOverflow){
      return "Center";
    }else if(topOverflow&&canPlaceBottom(extraSpace: targetRect.height)){
      return "Top";
    }else if(bottomOverflow&&canPlaceTop(extraSpace: targetRect.height)){
      return "Bottom";
    }else{
      //这是都两边都溢出的情况
      return "Center";
    }
  }

  String direction;
  //判断主方向,index由小到大
  if(preferDirection.index<=PreferDirection.topRight.index){
    direction=canPlaceTop()?"top":"bottom";
  }else if(preferDirection.index<=PreferDirection.bottomRight.index){
    direction=canPlaceBottom()?"bottom":"top";
  }else if(preferDirection.index<=PreferDirection.leftBottom.index){
    direction=canPlaceLeft()?"left":"right";
  }else{
    direction=canPlaceRight()?"right":"left";
  }

  //判断对齐方向
  if(preferDirection.index<=PreferDirection.bottomRight.index){
    switch(_getDirection(preferDirection).replaceAll("top", "").replaceAll("bottom", "")){
      case "Left":
        direction+=canPlaceRight(extraSpace: targetRect.width)?"Left":"Right";
        break;
      case "Center":
        direction+=inferHorizontalAlignDirection();
        break;
      case "Right":
        direction+=canPlaceLeft(extraSpace: targetRect.width)?"Right":"Left";
        break;
    }
  }else{
    switch(_getDirection(preferDirection).replaceAll("left", "").replaceAll("right", "")){
      case "Top":
        direction+=canPlaceBottom(extraSpace: targetRect.height)?"Top":"Bottom";
        break;
      case "Center":
        direction+=inferVerticalAlignDirection();
        break;
      case "Bottom":
        direction+=canPlaceTop(extraSpace: targetRect.height)?"Bottom":"Top";
        break;
    }
  }

  Offset resultOffset;
  switch(direction){
    case "topLeft":
      resultOffset=targetRect.topLeft-Offset(0, toastSize.height)+Offset(horizontalOffset,-verticalOffset,);
      break;
    case "topCenter":
      resultOffset=targetRect.topCenter-Offset(toastSize.width/2, toastSize.height)+Offset(0,-verticalOffset, );
      break;
    case "topRight":
      resultOffset=targetRect.topRight-Offset(toastSize.width, toastSize.height)+Offset(-horizontalOffset,-verticalOffset, );
      break;
    case "bottomLeft":
      resultOffset=targetRect.bottomLeft+Offset(horizontalOffset,verticalOffset);
      break;
    case "bottomCenter":
      resultOffset=targetRect.bottomCenter-Offset(toastSize.width/2, 0)+Offset(0, verticalOffset);
      break;
    case "bottomRight":
      resultOffset=targetRect.bottomRight-Offset(toastSize.width, 0)+Offset(-horizontalOffset, verticalOffset);
      break;
    case "leftTop":
      resultOffset=targetRect.topLeft-Offset(toastSize.width, 0)+Offset(-horizontalOffset, verticalOffset);
      break;
    case "leftCenter":
      resultOffset=targetRect.centerLeft-Offset(toastSize.width, toastSize.height/2)+Offset(-horizontalOffset, 0);
      break;
    case "leftBottom":
      resultOffset=targetRect.bottomLeft-Offset(toastSize.width, toastSize.height)+Offset(-horizontalOffset, -verticalOffset);
      break;
    case "rightTop":
      resultOffset=targetRect.topRight+Offset(horizontalOffset,verticalOffset);
      break;
    case "rightCenter":
      resultOffset=targetRect.centerRight-Offset(0, toastSize.height/2)+Offset(horizontalOffset, 0);
      break;
    case "rightBottom":
      resultOffset=targetRect.bottomRight-Offset(0, toastSize.height)+Offset(horizontalOffset, -verticalOffset);
      break;
  }

  return resultOffset;

}

String _getDirection(PreferDirection preferDirection ){
  return preferDirection.toString().replaceFirst("PreferDirection.", "");
}
