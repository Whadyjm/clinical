import 'package:flutter/material.dart';

class diente extends StatelessWidget {
  diente({
    super.key,
    required this.nro,
    required this.onPressed
  });

  String nro;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: MaterialButton(
        onPressed: onPressed,
        height: 35,
        minWidth: 35,
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Text(nro),
      ),
    );
  }
}
