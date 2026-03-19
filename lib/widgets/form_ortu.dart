import 'package:akusitumbuh/widgets/bg_create.dart';
import 'package:akusitumbuh/widgets/date_input.dart';
import 'package:akusitumbuh/widgets/gradient_button.dart';
import 'package:akusitumbuh/widgets/header.dart';
import 'package:akusitumbuh/widgets/input_form.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormOrtu extends StatefulWidget {
  final String email;
  final String password;

  const FormOrtu({super.key, required this.email, required this.password});

  @override
  State<FormOrtu> createState() => _FormOrtuState();
}

class _FormOrtuState extends State<FormOrtu> {
  final TextEditingController namaAnakController = TextEditingController();
  String? jenisKelamin;
  DateTime? tanggalLahir;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    namaAnakController.dispose();
    super.dispose();
  }

  void SignUp() {
    if (_formKey.currentState!.validate()) {
      // data lengkap siap dikirim
      print('Email: ${widget.email}');
      print('Password: ${widget.password}');
      print('Nama Anak: ${namaAnakController.text}');
      print('Jenis Kelamin: $jenisKelamin');
      print('Tanggal Lahir: $tanggalLahir');

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
                  const Icon(
                    Icons.family_restroom,
                    color: Color(0xFFD6A7C9),
                    size: 55,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Orang Tua',
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
                          hint: "Nama anak",
                          controller: namaAnakController,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Masukkan nama anak";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField(
                          value: jenisKelamin,
                          hint: Text(
                            'Jenis kelamin anak',
                            style: GoogleFonts.inriaSerif(
                              color: const Color(0xFF9472C0).withOpacity(0.5),
                              fontSize: 16,
                            ),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'L',
                              child: Text(
                                'Laki-laki',
                                style: GoogleFonts.inriaSerif(fontSize: 16),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'P',
                              child: Text(
                                'Perempuan',
                                style: GoogleFonts.inriaSerif(fontSize: 16),
                              ),
                            ),
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD6A7C9)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFD6A7C9)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null)
                              return "Pilih jenis kelamin anak";
                            return null;
                          },
                          onChanged: (value) =>
                              setState(() => jenisKelamin = value),
                        ),
                        const SizedBox(height: 20),
                        DateInput(
                          hint: 'Tanggal lahir anak',
                          onDateSelected: (date) {
                            setState(() => tanggalLahir = date);
                          },
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
