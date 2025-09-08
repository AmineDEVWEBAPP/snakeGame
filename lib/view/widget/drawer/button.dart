import 'package:flutter/material.dart';

import '../../../controller/theme_controller.dart';
import 'expanded_dialog.dart';

class GameDrawerButton extends StatelessWidget {
  GameDrawerButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.isOpen,
    required this.onChoice,
    required this.data,
    required this.groupValue,
  });
  final IconData icon;
  final String title;
  final void Function() onTap;
  final bool isOpen;
  final void Function(dynamic value) onChoice;
  final List<Map<String, dynamic>> data;
  final dynamic groupValue;
  final ThemeData _theme = ThemeController.theme;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: size.height * 0.050,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: _theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: [
                Icon(icon),
                SizedBox(width: size.width * 0.1),
                Text(title),
              ],
            ),
          ),
        ),
        ExpandedDialog(
          isOpen: isOpen,
          groupValue: groupValue,
          data: data,
          onTap: (value) async {
            onChoice(value);
          },
        ),
      ],
    );
  }
}
