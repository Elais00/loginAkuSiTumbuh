import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;
  final Color outlineColor;
  final double strokeWidth;
  final FontWeight fontWeight;

  const OutlinedText({
    super.key,
    required this.text,
    this.fontSize = 24,
    this.textColor = Colors.white,
    this.outlineColor = Colors.black,
    this.strokeWidth = 4,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: GoogleFonts.jomhuria(
            fontSize: 50,
            fontWeight: fontWeight,
            height: 0.7,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = Color(0xFFCEAABD),
            letterSpacing: 3,
          ),
        ),
        Text(
          text,
          style: GoogleFonts.jomhuria(
            fontSize: 50,
            fontWeight: fontWeight,
            height: 0.7,
            color: Colors.white,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}
