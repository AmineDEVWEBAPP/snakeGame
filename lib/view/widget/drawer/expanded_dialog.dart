import 'package:flutter/material.dart';

import '../../../controller/theme_controller.dart';

class ExpandedDialog extends StatefulWidget {
  const ExpandedDialog({
    super.key,
    this.offset,
    required this.isOpen,
    required this.data,
    required this.onTap,
    required this.groupValue,
  });
  final Offset? offset;
  final bool isOpen;
  final List<Map<String, dynamic>> data;
  final void Function(dynamic v) onTap;
  final dynamic groupValue;

  @override
  State<ExpandedDialog> createState() => _ExpandedDialogState();
}

class _ExpandedDialogState extends State<ExpandedDialog> {
  final ThemeData _theme = ThemeController.theme;

  dynamic _groupValue;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: widget.offset ?? Offset(0, 0),
      child: Container(
        height: widget.isOpen ? null : 0,
        decoration: BoxDecoration(
          color: _theme.cardColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: Column(
          children: List.generate(
            widget.data.length,
            (i) => RadioListTile(
              value: widget.data[i].values.elementAt(0),
              groupValue: _groupValue ?? widget.groupValue,
              onChanged: (v) async {
                _groupValue = v;
                setState(() {});
                await Future.delayed(const Duration(milliseconds: 250));
                widget.onTap(v);
                _groupValue = widget.groupValue;
              },
              title: Text(
                widget.data[i].keys.elementAt(0),
                style: _theme.textTheme.bodyMedium,
              ),
              fillColor: WidgetStatePropertyAll(_theme.secondaryHeaderColor),
            ),
          ),
        ),
      ),
    );
  }
}
