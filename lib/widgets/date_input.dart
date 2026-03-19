import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateInput extends StatefulWidget {
  final String hint;
  final Function(DateTime)? onDateSelected;

  const DateInput({super.key, required this.hint, this.onDateSelected});

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  final TextEditingController _dateController = TextEditingController();

  Future<void> _pickDate() async {
    final now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(
        now.year - 2,
        now.month,
        now.day,
      ), // mulai dari 2 tahun lalu
      firstDate: DateTime(now.year - 5, now.month, now.day), // maksimal 5 tahun
      lastDate: DateTime(now.year - 2, now.month, now.day), // minimal 2 tahun
    );

    if (picked != null) {
      setState(() {
        _dateController.text =
            '${picked.day.toString().padLeft(2, '0')}/'
            '${picked.month.toString().padLeft(2, '0')}/'
            '${picked.year}';
      });
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _dateController,
      readOnly: true,
      onTap: _pickDate,

      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: GoogleFonts.inriaSerif(
          color: const Color(0xFF9472C0).withOpacity(0.5),
          fontSize: 16,
        ),

        suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFFD6A7C9)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD6A7C9)),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
