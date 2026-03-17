import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:akusitumbuh/widgets/input_login.dart';
import 'package:akusitumbuh/widgets/outlined_text.dart';
import 'package:akusitumbuh/widgets/wavy_banner.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                Icon(Icons.arrow_back, color: Colors.white, size: 30),

                SizedBox(height: 7),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedText(text: 'Login Account'),
                      SizedBox(height: 2),
                      Text(
                        'Welcome Back !',
                        style: GoogleFonts.libreCaslonText(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 100),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 60),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 40,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFFB7C8E8).withOpacity(0.5),
                                Color(0xFFF5B6D7).withOpacity(0.5),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                            border: Border.symmetric(
                              vertical: BorderSide(
                                color: Color(0xFFD6A7C9),
                                width: 4,
                              ),
                            ),
                          ),

                          child: Column(
                            children: [
                              CustomInput(
                                hint: 'Masukkan email',
                                icon: Icons.email_outlined,
                              ),
                              SizedBox(height: 20),
                              CustomInput(
                                hint: 'Masukkan password',
                                icon: Icons.lock_outline,
                                isPassword: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 80),
                          child: GradientButton(
                            text: "Login",
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GoogleFonts.libreFranklin(
                                color: Color(0xFFB7C8E8),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 3),
                            GestureDetector(
                              onTap: () {
                                //pindah halaman sign up
                              },
                              child: Text(
                                "Sign Up",
                                style: GoogleFonts.libreFranklin(
                                  color: Color(0xFF849AC3),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
