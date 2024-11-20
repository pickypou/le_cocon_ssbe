import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme.dart';

class LinkButton extends StatefulWidget {
  final String label;
  final String url;
  final double? fontSize;

  const LinkButton({
    super.key,
    required this.label,
    required this.url,
    this.fontSize,
  });

  @override
  State<LinkButton> createState() => _LinkButtonState();
}

class _LinkButtonState extends State<LinkButton> {
  bool _isPressed = false;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Impossible d\'ouvrir le lien : $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth > 749 ? 450.0 : 300.0;
    double calculatedFontSize =
        widget.fontSize ?? (size.width > 749 ? size.width / 75 : 18);

    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: GestureDetector(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          child: ElevatedButton(
            onPressed: () => _launchURL(widget.url),
            style: ButtonStyle(
              padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 15),
              ),
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (states) {
                  if (states.contains(WidgetState.pressed)) {
                    return theme.colorScheme.secondary;
                  }
                  return theme.colorScheme.primary;
                },
              ),
              shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
                    (states) {
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(
                      color: theme.colorScheme.onPrimary,
                      width: states.contains(WidgetState.pressed) ? 3.0 : 3.0,
                    ),
                  );
                },
              ),
            ),
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