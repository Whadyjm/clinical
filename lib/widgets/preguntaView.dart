import 'package:clinical/widgets/pregunta.dart';
import 'package:clinical/widgets/siONo.dart';
import 'package:flutter/material.dart';

class PreguntaView extends StatelessWidget {
  const PreguntaView({
    super.key,
    required this.text,
    required this.numberPage,
  });

  final String text;
  final String numberPage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(numberPage),
                ],
              ),
            ),
            Pregunta(pregunta: text,),
            const SizedBox(height: 40,),
            const SiONo(),
          ],
        )
    );
  }
}