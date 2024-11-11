import 'package:flutter/material.dart';
import 'package:le_cocon_ssbe/ui/theme.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? fontSize;
  const CustomButton({super.key, required this.label, required this.onPressed, this.fontSize});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth > 749 ?  450.0 : 300.0 ;
    double calculatedFontSize =
        fontSize ?? (size.width > 749 ? size.width / 75 : 18);



    return Center(
      child: SizedBox(
        width: buttonWidth,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(
                const EdgeInsets.symmetric(vertical: 2)),
            backgroundColor: WidgetStateProperty.all(theme.colorScheme.surface),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  side: BorderSide(color: theme.colorScheme.onSurface)
                ))
          ),
            onPressed: onPressed,
            child: Text(label, style: textStyleText(context).copyWith(fontSize:calculatedFontSize ),)),
      ),
    );

  }
}

