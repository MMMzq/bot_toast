import 'package:flutter/material.dart';

//加载提示的Widget
class LoadingWidget extends StatelessWidget {
  LoadingWidget({Key key}) : super(key: key);

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