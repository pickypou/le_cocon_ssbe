import 'package:flutter/material.dart';
import '../../theme.dart';

class CustomButton extends StatefulWidget {
  final String label;
  final double? fontSize;
  final VoidCallback? onPressed;

  const CustomButton({
    required this.label,
    this.onPressed,
    this.fontSize,
    super.key,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    double calculatedFontSize =
        widget.fontSize ?? (size.width > 749 ? size.width / 60 : 20);

    double buttonWidth = screenWidth * 0.8;
    if (screenWidth > 500) {
      buttonWidth = 400.0;
    }

    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          child: ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 15),
              ),
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return theme.colorScheme.secondary;
                  }
                  return theme.colorScheme.primary;
                },
              ),
              shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                    (states) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: theme.colorScheme.onPrimary,
                      width: states.contains(MaterialState.pressed) ? 3.0 : 3.0,
                    ),
                  );
                },
              ),
            ),
            onPressed: widget.onPressed ?? () {},
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: calculatedFontSize,
                color: _isPressed
                    ? theme.colorScheme.surface
                    : theme.colorScheme.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}