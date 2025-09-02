import 'package:flutter/material.dart';

class Points extends StatelessWidget {
  const Points({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'P : 19',
        style: TextStyle(color: Colors.yellow, fontSize: 17),
      ),
    );
  }
}
