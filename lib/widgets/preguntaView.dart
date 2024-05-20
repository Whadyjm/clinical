import 'package:clinical/widgets/pregunta.dart';
import 'package:clinical/widgets/siONo.dart';
import 'package:flutter/material.dart';

class PreguntaView extends StatelessWidget {
  PreguntaView({
    super.key,
    required this.text,
    required this.numberPage,
    this.onTapYes,
    this.onTapNo,
  });

  final String text;
  final String numberPage;
  void Function()? onTapYes;
  void Function()? onTapNo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Pregunta(pregunta: text,),
            const SizedBox(height: 40,),
            SiONo(onTapYes: onTapYes, onTapNo: onTapNo,),
          ],
        )
    );
  }
}