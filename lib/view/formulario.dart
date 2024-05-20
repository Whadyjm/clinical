import 'package:clinical/widgets/diente.dart';
import 'package:clinical/widgets/odontograma.dart';
import 'package:clinical/widgets/pregunta.dart';
import 'package:clinical/widgets/preguntaView.dart';
import 'package:clinical/widgets/siONo.dart';
import 'package:clinical/widgets/textForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _edadController = TextEditingController();
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();

  late DateTime? _selectedDate = DateTime.now();
  final auth = FirebaseAuth.instance;


  Future<void> showDate () async {
    _selectedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(1950),
        lastDate: DateTime.now()
    );
    if (_selectedDate != null) {
      setState(() {});
    }
  }

  final PageController controller = PageController(initialPage: 0);
  late int currentPage = 0;
  bool fin = false;

  List<String> respuestas = [];

  List<Step> stepList() => [

    Step(
      state: _activeStep <= 0 ? StepState.indexed:StepState.complete,
      isActive: _activeStep >= 0,
        title: Text(
      'Datos personales',
      style: GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
      ),
    ), content: Center(
      child: Column(
        children: [
          const SizedBox(height: 20,),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: TextForm(
              controller: _nameController,
                keyboardType: TextInputType.text,
                hint: 'Nombre y apellido',
                fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: TextForm(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              hint: 'Teléfono',
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 60,
                  width: 100,
                  child: TextForm(
                    controller: _edadController,
                    keyboardType: TextInputType.number,
                    hint: 'Edad',
                    fillColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                child: SizedBox(
                  height: 60,
                  width: 100,
                  child: TextForm(
                    controller: _cedulaController,
                    keyboardType: TextInputType.number,
                    hint: 'Cédula',
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50)
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: (){
                      showDate();
                }, icon: const Icon(Icons.calendar_month_rounded),
                ),
                const SizedBox(width: 5,),
                Text(DateFormat('dd/MM/yy').format(_selectedDate!), style: const TextStyle(fontSize: 18),)
              ],
            )
          ),
          const SizedBox(height: 30,),
        ],
      )
    )),

    Step(
        state: _activeStep <= 1 ? StepState.indexed:StepState.complete,
        isActive: _activeStep >= 1,
        title: Text(
          'Historial clínico',
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ), content: Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(21)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: Center(child: Text('${currentPage+1}/32'))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  children: [
                    PreguntaView( /// Pregunta Nº 1
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                        },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Esta bajo tratamiento médico?', numberPage: '1/32',),
                    PreguntaView( /// Pregunta Nº 2
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Actualmente toma algún medicamento?', numberPage: '2/32',),
                    PreguntaView( /// Pregunta Nº 3
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Le han practicado alguna intervención quirúrgica?', numberPage: '3/32',),
                    PreguntaView( /// Pregunta Nº 4
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Ha recibido alguna transfusión sanguínea?', numberPage: '4/32',),
                    PreguntaView( /// Pregunta Nº 5
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Ha consumido o consume drogas?', numberPage: '5/32',),
                    PreguntaView( /// Pregunta Nº 6
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Ha presentado reacción alérgica a la Penicilina?', numberPage: '6/32',),
                    PreguntaView( /// Pregunta Nº 7
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Ha presentado reacción alérgica a la Anestesia?', numberPage: '7/32',),
                    PreguntaView( /// Pregunta Nº 8
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Ha presentado reacción alérgica a: Aspirina, Yodo, Merthiolate, entre otros?', numberPage: '8/32',),
                    PreguntaView( /// Pregunta Nº 9
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre de tensión arterial alta?', numberPage: '9/32',),
                    PreguntaView( /// Pregunta Nº 10
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre de tensión arterial baja?', numberPage: '10/32',),
                    PreguntaView( /// Pregunta Nº 11
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sangra excesivamente al cortarse?', numberPage: '11/32',),
                    PreguntaView( /// Pregunta Nº 12
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Padece o ha padecido de algún problema sanguíneo? (Anemia, leucemia, entre otros)', numberPage: '12/32',),
                    PreguntaView( /// Pregunta Nº 13
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Es usted VIH positivo?', numberPage: '13/32',),
                    PreguntaView( /// Pregunta Nº 14
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Toma algún medicamento retroviral?', numberPage: '14/32',),
                    PreguntaView( /// Pregunta Nº 15
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Esta usted embarazada?', numberPage: '15/32',),
                    PreguntaView( /// Pregunta Nº 16
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Actualmente toma pastillas anticonceptivas?', numberPage: '16/32',),
                    PreguntaView( /// Pregunta Nº 17
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre o ha sufrido de enfermedades venéreas?', numberPage: '17/32',),
                    PreguntaView( /// Pregunta Nº 18
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre o ha sufrido de problemas del corazón?', numberPage: '18/32',),
                    PreguntaView( /// Pregunta Nº 19
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre o ha sufrido de Hepatitis Tipo A, B o C?', numberPage: '19/32',),
                    PreguntaView( /// Pregunta Nº 20
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre o ha sufrido de fiebre reumática?', numberPage: '20/32',),
                    PreguntaView( /// Pregunta Nº 21
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre o ha sufrido de Asma?', numberPage: '21/32',),
                    PreguntaView( /// Pregunta Nº 22
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre o ha sufrido de Diábetes?', numberPage: '22/32',),
                    PreguntaView( /// Pregunta Nº 23
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre o ha sufrido de Úlcera gástrica?', numberPage: '23/32',),
                    PreguntaView( /// Pregunta Nº 24
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre o ha sufrido de Tiroides?', numberPage: '24/32',),
                    PreguntaView( /// Pregunta Nº 25
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Ha tenido limitación al abrir o cerrar la boca?', numberPage: '25/32',),
                    PreguntaView( /// Pregunta Nº 26
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Siente ruidos en la mandibula al abrir o cerrar la boca?', numberPage: '26/32',),
                    PreguntaView( /// Pregunta Nº 27
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Sufre de herpes o aftas recurrentes?', numberPage: '27/32',),
                    PreguntaView( /// Pregunta Nº 28
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Tiene hábito de morderse las uñas o labios?', numberPage: '28/32',),
                    PreguntaView( /// Pregunta Nº 29
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Tiene hábito de fumar a diario?', numberPage: '29/32',),
                    PreguntaView( /// Pregunta Nº 30
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Tiene hábito de consumir alimentos cítricos?', numberPage: '30/32',),
                    PreguntaView( /// Pregunta Nº 31
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Tiene hábito de apretamiento dentario?', numberPage: '31/32',),
                    PreguntaView( /// Pregunta Nº 32
                      onTapYes: (){
                        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                        respuestas.add('si');
                        fin = true;
                        print(respuestas);
                        setState(() {
                          currentPage++;
                        });
                      },
                      onTapNo: (){controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                      respuestas.add('no');
                      fin = true;
                      print(respuestas);
                      setState(() {
                        currentPage++;
                      });
                      }
                      ,text: '¿Tiene hábito de respiración bucal?', numberPage: '32/32',),

                  ],
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Visibility(
            //       visible: currentPage == 0 ? false:true,
            //       child: IconButton(
            //           onPressed: (){
            //             controller.previousPage(duration: const Duration(seconds: 1), curve: Curves.ease);
            //             setState(() {
            //               currentPage --;
            //             });
            //           },
            //           icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            //     ),
            //     Visibility(
            //       visible: currentPage == 31 ? false:true,
            //       child: IconButton(
            //           onPressed: (){
            //             cconst ontroller.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
            //             setState(() {
            //               currentPage ++;
            //             });
            //           },
            //           icon: const Icon(Icons.arrow_forward_ios_rounded)),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    )),

    Step(
        state: _activeStep <= 2 ? StepState.indexed:StepState.complete,
        isActive: _activeStep >= 2,
        title: Text(
          'Odontograma',
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ), 
        content: const Center(
          child: Odontograma(),
            )),
    Step(
        state: _activeStep <= 2 ? StepState.indexed:StepState.complete,
        isActive: _activeStep >= 2,
        title: Text(
          'Plan de tratamiento',
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ), content: Center(
      child: Text(
        'Plan de tratamiento',
        style: GoogleFonts.montserrat(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ),
      ),
    )),
  ];

  int _activeStep = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 1000,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Historia clínica del paciente',
                          style: GoogleFonts.montserrat(
                            textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50,),
                  Stepper(
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 40,),
                            Visibility(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:[
                                  Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: TextButton(
                                      onPressed: details.onStepContinue,
                                      child: Center(child: _activeStep == 3 ? const Text('Guardar', ):const Text('Siguiente', )),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: TextButton(
                                      onPressed: details.onStepCancel,
                                      child: const Center(child: Text('Anterior', )),
                                    ),
                                  ),
                                ]
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                      type: StepperType.vertical,
                      currentStep: fin ? 2:_activeStep,
                      steps: stepList(),
                  onStepContinue: () {
                  //
                  //   if (_nameController.text.isNotEmpty
                  //       && _phoneController.text.isNotEmpty
                  //       && _edadController.text.isNotEmpty
                  //       && _cedulaController.text.isNotEmpty && (_selectedDate != null)){
                  //
                  //     FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).update({
                  //       'userPacientes': FieldValue.arrayUnion([
                  //         {
                  //           'nombre': _nameController.text.trim(),
                  //           'telefono': _phoneController.text.trim(),
                  //           'edad': _edadController.text.trim(),
                  //           'cedula': _cedulaController.text.trim(),
                  //           'fecha': _selectedDate,
                  //         }
                  //       ])
                  //
                  //     });
                  //
                       setState(() {});
                      if(_activeStep<(stepList().length - 1)) {
                        _activeStep += 1;
                      }
                  //   } else {
                  //     showDialog(context: context, builder: (context){
                  //       return AlertDialog(
                  //         content: SizedBox(
                  //             height: 80,
                  //             width: 100,
                  //             child: Center(
                  //               child: Text(
                  //                 'Llena los datos personales para continuar',
                  //                 style: GoogleFonts.montserrat(
                  //                   textStyle: Theme.of(context).textTheme.displayLarge,
                  //                   fontSize: 18,
                  //                   fontWeight: FontWeight.w700,
                  //                   fontStyle: FontStyle.normal,
                  //                 ),
                  //               ),)),
                  //       );
                  //     });
                  //   }
                  },
                    onStepCancel: (){
                      if (_activeStep == 0){
                        return;
                      }
                      _activeStep -= 1;
                      setState(() {});
                    },
                  onStepTapped: (value) {
                        _activeStep = value;
                        setState(() {});
                  },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}