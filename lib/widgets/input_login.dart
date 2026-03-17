import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInput extends StatefulWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;

  const CustomInput({
    super.key,
    required this.hint,
    required this.icon,
    this.isPassword = false,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 50,
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.only(left: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.8),
                Colors.white.withOpacity(0.1),
              ],
            ),
          ),
          child: TextField(
            style: GoogleFonts.libreCaslonText(color: Color(0xFF9472C0)),
            obscureText: widget.isPassword ? isObscure : false,
            decoration: InputDecoration(
              hintText: widget.hint,
              isCollapsed: true,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
              hintStyle: GoogleFonts.libreCaslonText(
                color: Color(0xFF9472C0).withOpacity(0.5),
              ),
              border: InputBorder.none,

              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 19,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),

        Positioned(
          left: 0,
          top: 0,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Color(0xFFD6A7C9),
            child: Icon(widget.icon, color: Colors.white, size: 27),
          ),
        ),
      ],
    );
  }
}
