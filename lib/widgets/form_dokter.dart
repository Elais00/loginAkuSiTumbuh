import 'package:akusitumbuh/widgets/bg_create.dart';
import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:akusitumbuh/widgets/header.dart';
import 'package:akusitumbuh/widgets/input_form.dart';
import 'package:akusitumbuh/widgets/time_input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class FormDokter extends StatefulWidget {
  final String email;
  final String password;

  const FormDokter({super.key, required this.email, required this.password});

  @override
  State<FormDokter> createState() => _FormDokterState();
}

class _FormDokterState extends State<FormDokter> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController STRController = TextEditingController();
  final TextEditingController praktikController = TextEditingController();

  TimeOfDay? jamMulai;
  TimeOfDay? jamSelesai;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    namaController.dispose();
    STRController.dispose();
    praktikController.dispose();
    super.dispose();
  }

  void SignUp() {
    if (_formKey.currentState!.validate()) {
      print('Email: ${widget.email}');
      print('Password: ${widget.password}');
      print('Nama: ${namaController.text}');
      print('STR: ${STRController.text}');
      print('Praktik: ${praktikController.text}');
      print('Jam Mulai: $jamMulai');
      print('Jam Selesai: $jamSelesai');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Sign up berhasil",
            style: GoogleFonts.inriaSerif(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 164, 183, 214),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeaderWidget(
              title: 'Create Account',
              subtitle: 'Sign up to continue',
              onBack: () => Navigator.pop(context),
            ),
            const SizedBox(height: 80),
            BgCreate(
              isFullHeight: true,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(50),
              ),
              colors: [
                const Color(0xFFB7C8E8).withOpacity(0.25),
                const Color(0xFFD6A7C9).withOpacity(0.25),
              ],
              child: Column(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.userDoctor,
                    color: Color(0xFFD6A7C9),
                    size: 55,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Dokter',
                    style: GoogleFonts.inriaSerif(
                      fontSize: 18,
                      color: const Color(0xFFD6A7C9),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputForm(
                          hint: "Nama lengkap",
                          controller: namaController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Masukkan nama lengkap Anda";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        InputForm(
                          hint: 'Nomor STR',
                          controller: STRController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Masukkan nomor STR";
                            }
                            if (value.length < 10) {
                              return "Nomor STR tidak valid";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        InputForm(
                          hint: 'Tempat praktik',
                          controller: praktikController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Masukkan nama tempat Anda praktik";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TimeInput(
                                hint: 'Jam mulai',
                                onTimeSelected: (time) {
                                  setState(() => jamMulai = time);
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TimeInput(
                                hint: 'Jam selesai',
                                onTimeSelected: (time) {
                                  if (jamMulai != null) {
                                    final mulai =
                                        jamMulai!.hour * 60 + jamMulai!.minute;
                                    final selesai =
                                        time.hour * 60 + time.minute;
                                    if (selesai <= mulai) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Jam selesai harus lebih dari jam mulai!',
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }
                                  }
                                  setState(() => jamSelesai = time);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: GradientButton(
                            text: 'Sign up',
                            onPressed: SignUp,
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
      ),
    );
  }
}
