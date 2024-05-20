import 'package:clinical/widgets/diente.dart';
import 'package:clinical/widgets/esquemaDental.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Odontograma extends StatelessWidget {
  const Odontograma({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: SizedBox(
        width: 600,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: [
                    Row(
                      children: [
                        diente(nro: '18', onPressed: () {
                          showDialog(context: context, builder: (context){
                            return EsquemaDental(nro: '18',);
                          });},),
                        diente(nro: '17', onPressed: () {
                          showDialog(context: context, builder: (context){
                            return EsquemaDental(nro: '17',);
                          });
                        },),
                        diente(nro: '16', onPressed: () {
                          showDialog(context: context, builder: (context){
                            return EsquemaDental(nro: '16',);
                          });
                        },),
                        diente(nro: '15', onPressed: () {
                          showDialog(context: context, builder: (context){
                            return EsquemaDental(nro: '15',);
                          });
                        },),
                        diente(nro: '14', onPressed: () {showDialog(context: context, builder: (context){
                          return EsquemaDental(nro: '14',);
                        });},),
                        diente(nro: '13', onPressed: () {
                          showDialog(context: context, builder: (context){
                            return EsquemaDental(nro: '13',);
                          });
                        },),
                        diente(nro: '12', onPressed: () {
                          showDialog(context: context, builder: (context){
                            return EsquemaDental(nro: '12',);
                          });
                        },),
                        diente(nro: '11', onPressed: () {
                          showDialog(context: context, builder: (context){
                            return EsquemaDental(nro: '11',);
                          });
                        },),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        diente(nro: '51', onPressed: () {  },),
                        diente(nro: '52', onPressed: () {  },),
                        diente(nro: '53', onPressed: () {  },),
                        diente(nro: '54', onPressed: () {  },),
                        diente(nro: '55', onPressed: () {  },),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 80, child: VerticalDivider()),
                Column(
                  children: [
                    Row(
                      children: [
                        diente(nro: '21', onPressed: () {  },),
                        diente(nro: '22', onPressed: () {  },),
                        diente(nro: '23', onPressed: () {  },),
                        diente(nro: '24', onPressed: () {  },),
                        diente(nro: '25', onPressed: () {  },),
                        diente(nro: '26', onPressed: () {  },),
                        diente(nro: '27', onPressed: () {  },),
                        diente(nro: '28', onPressed: () {  },),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        diente(nro: '61', onPressed: () {  },),
                        diente(nro: '62', onPressed: () {  },),
                        diente(nro: '63', onPressed: () {  },),
                        diente(nro: '64', onPressed: () {  },),
                        diente(nro: '65', onPressed: () {  },),
                      ],
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        diente(nro: '81', onPressed: () {  },),
                        diente(nro: '82', onPressed: () {  },),
                        diente(nro: '83', onPressed: () {  },),
                        diente(nro: '84', onPressed: () {  },),
                        diente(nro: '85', onPressed: () {  },),
                        const SizedBox(width: 20,)
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        diente(nro: '48', onPressed: () {  },),
                        diente(nro: '47', onPressed: () {  },),
                        diente(nro: '46', onPressed: () {  },),
                        diente(nro: '45', onPressed: () {  },),
                        diente(nro: '44', onPressed: () {  },),
                        diente(nro: '43', onPressed: () {  },),
                        diente(nro: '42', onPressed: () {  },),
                        diente(nro: '41', onPressed: () {  },),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 80, child: VerticalDivider()),
                Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 20,),
                        diente(nro: '71', onPressed: () {  },),
                        diente(nro: '72', onPressed: () {  },),
                        diente(nro: '73', onPressed: () {  },),
                        diente(nro: '74', onPressed: () {  },),
                        diente(nro: '75', onPressed: () {  },),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(width: 18,),
                        diente(nro: '31', onPressed: () {  },),
                        diente(nro: '32', onPressed: () {  },),
                        diente(nro: '33', onPressed: () {  },),
                        diente(nro: '34', onPressed: () {  },),
                        diente(nro: '35', onPressed: () {  },),
                        diente(nro: '36', onPressed: () {  },),
                        diente(nro: '37', onPressed: () {  },),
                        diente(nro: '38', onPressed: () {  },),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
