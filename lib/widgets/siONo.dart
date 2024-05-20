import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SiONo extends StatelessWidget {
  SiONo({
    super.key,
    this.onTapYes,
    this.onTapNo,
  });

  void Function()? onTapYes;
  void Function()? onTapNo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          height: 70,
          minWidth: 100,
          color: Colors.green.shade300,
          onPressed: onTapYes,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Text(
            'SI',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        MaterialButton(
          height: 70,
          minWidth: 100,
          color: Colors.red.shade300,
          onPressed: onTapNo,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Text(
            'No',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }
}