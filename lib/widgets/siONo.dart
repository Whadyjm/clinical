import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SiONo extends StatelessWidget {
  const SiONo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            height: 70,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.green.shade300,
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomLeft: Radius.circular(50))
            ),
            child: Center(
              child: Text(
                'SI',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            height: 70,
            width: 100,
            decoration: BoxDecoration(
                color: Colors.red.shade300,
                borderRadius: const BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50))
            ),
            child: Center(
              child: Text(
                'No',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}