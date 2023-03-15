import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ColorPickerDialog extends StatefulWidget {
  final Color? color;
  const ColorPickerDialog({Key? key, this.color}) : super(key: key);

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  Color _selectedColor = Colors.blue;

  @override
  void initState() {
    if(widget.color != null) _selectedColor = widget.color!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick a color'),
      content: SingleChildScrollView(
        child: ColorPicker(
          color: _selectedColor,
          onColorChanged: (Color color) {
            setState(() => _selectedColor = color);
          },
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.both: true,
            ColorPickerType.primary: true,
            ColorPickerType.accent: true,
            ColorPickerType.bw: true,
            ColorPickerType.custom: true,
            ColorPickerType.wheel: true
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.of(context).pop(_selectedColor);
          },
        ),
      ],
    );
  }
}
