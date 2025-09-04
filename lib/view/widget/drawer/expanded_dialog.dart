import 'package:flutter/material.dart';

import '../../../core/config/theme.dart';

class ExpandedDialog extends StatefulWidget {
  const ExpandedDialog({
    super.key,
    this.offset,
    required this.isOpen,
    required this.data,
    required this.onTap,
  });
  final Offset? offset;
  final bool isOpen;
  final List<Map<String, dynamic>> data;
  final void Function(dynamic v) onTap;

  @override
  State<ExpandedDialog> createState() => _ExpandedDialogState();
}

class _ExpandedDialogState extends State<ExpandedDialog> {
  final ThemeData _theme = AppTheme.theme;

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
              groupValue: _groupValue,
              onChanged: (v) async {
                _groupValue = v;
                setState(() {});
                await Future.delayed(const Duration(milliseconds: 250));
                widget.onTap(v);
              },
              title: Text(
                widget.data[i].keys.elementAt(0),
                style: _theme.textTheme.bodyMedium,
              ),
              fillColor: WidgetStatePropertyAll(Colors.yellow),
            ),
          ),
        ),
      ),
    );
  }
}
