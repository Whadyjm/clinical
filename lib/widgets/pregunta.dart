import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pregunta extends StatelessWidget {
  Pregunta({
    super.key, required this.pregunta});

  String pregunta;

  @override
  Widget build(BuildContext context) {
    return Text(
      pregunta,
      style: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
    );
  }
}