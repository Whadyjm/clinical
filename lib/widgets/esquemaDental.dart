import 'package:flutter/material.dart';

class EsquemaDental extends StatelessWidget {
  EsquemaDental({
    super.key,
    required this.nro
  });

  String nro;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text(nro)),
      backgroundColor: Colors.transparent,
      content: Container(
        height: 300,
        width: 300,
        decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: (){},
              height: 80,
              minWidth: 150,
              color: Colors.grey.shade300,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: (){},
                  height: 150,
                  minWidth: 80,
                  color: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
                ),
                MaterialButton(
                  onPressed: (){},
                  height: 150,
                  minWidth: 150,
                  color: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                ),
                MaterialButton(
                  onPressed: (){},
                  height: 150,
                  minWidth: 80,
                  color: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
                ),
              ],
            ),
            MaterialButton(
              onPressed: (){},
              height: 80,
              minWidth: 150,
              color: Colors.grey.shade300,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
            ),
          ],
        ),
      ),
    );
  }
}