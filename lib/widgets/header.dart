import 'package:akusitumbuh/widgets/wavy_banner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showBackButton;
  final VoidCallback? onBack;
  final double fontSize;
  final double strokeWidth;
  final FontWeight fontWeight;

  const HeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.showBackButton = true,
    this.onBack,
    this.fontSize = 24,
    this.strokeWidth = 4,
    this.fontWeight = FontWeight.bold,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ClipPath(
              clipper: WavyBannerClipper(),
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFCCDDFB), Color(0xFFFFC9E6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 60, left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showBackButton)
                    IconButton(
                      onPressed: onBack ?? () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                  SizedBox(height: 7),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Text(
                              title,
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
                              title,
                              style: GoogleFonts.jomhuria(
                                fontSize: 50,
                                fontWeight: fontWeight,
                                height: 0.7,
                                color: Colors.white,
                                letterSpacing: 3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: GoogleFonts.libreCaslonText(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
