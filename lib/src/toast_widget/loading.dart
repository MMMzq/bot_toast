import 'package:flutter/material.dart';

//加载提示的Widget
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: const CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    );
  }
}
