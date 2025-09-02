import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ControlleButtons extends StatelessWidget {
  ControlleButtons({super.key, this.left, this.right, this.top, this.bottom});
  final void Function()? left;
  final void Function()? right;
  final void Function()? top;
  final void Function()? bottom;
  double bSize = (Get.width * 0.45) / 3;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.45,
      height: Get.width * 0.45,
      child: Row(
        children: [
          _left(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_top(), _bottom()],
          ),
          _right(),
        ],
      ),
    );
  }

  Widget _left() => InkWell(
    onTap: left,
    child: Container(
      width: bSize,
      height: bSize,
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.arrow_back_ios_new),
    ),
  );
  Widget _right() => InkWell(
    onTap: right,
    child: Container(
      width: bSize,
      height: bSize,
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(Icons.arrow_forward_ios),
    ),
  );
  Widget _top() => InkWell(
    onTap: top,
    child: Container(
      width: bSize,
      height: bSize,
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RotatedBox(quarterTurns: 1, child: Icon(Icons.arrow_back_ios_new)),
    ),
  );
  Widget _bottom() => InkWell(
    onTap: bottom,
    child: Container(
      width: bSize,
      height: bSize,
      decoration: BoxDecoration(
        color: Colors.white38,
        borderRadius: BorderRadius.circular(10),
      ),
      child: RotatedBox(
        quarterTurns: -1,
        child: Icon(Icons.arrow_back_ios_new),
      ),
    ),
  );
}
