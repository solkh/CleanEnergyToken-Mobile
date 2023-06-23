import 'package:flutter/material.dart';

class ArrowWidget extends StatelessWidget {
  final Color color;
  final double size;
  const ArrowWidget({this.color = Colors.grey, this.size = 24});

  static IconData getArrowIconData() {
    return Icons.arrow_forward_ios_outlined;
  }

  @override
  Widget build(BuildContext context) {
    return Icon(ArrowWidget.getArrowIconData(), color: color, size: size);
  }
}
