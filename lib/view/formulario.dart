import 'package:clinical/widgets/textForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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


  List <Step> stepList() => [

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
                    //   showCupertinoModalPopup(context: context, builder: (context){
                    //   return SizedBox(
                    //     height: 250,
                    //     child:
                    //
                    //     // CupertinoDatePicker(
                    //     //     dateOrder: DatePickerDateOrder.dmy,
                    //     //     mode: CupertinoDatePickerMode.date,
                    //     //     initialDateTime: DateTime.now(),
                    //     //     backgroundColor: Colors.white,
                    //     //     onDateTimeChanged: (DateTime newTime){
                    //     //       setState(() {
                    //     //         _selectedDate = newTime;
                    //     //       });
                    //     //     }),
                    //   );
                    // }
                    // );
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
      child: Text(
        'Historial clínico',
        style: GoogleFonts.montserrat(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ),
      ),
    )),

    Step(
        state: _activeStep <= 2 ? StepState.indexed:StepState.complete,
        isActive: _activeStep >= 2,
        title: Text(
          'Odontodiagrama',
          style: GoogleFonts.montserrat(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
        ), content: Center(
      child: Text(
        'Odontodiagrama',
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
                                child: const Center(child: Text('Siguiente', )),
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
                      );
                    },
                      type: StepperType.vertical,
                      currentStep: _activeStep,
                      steps: stepList(),
                  onStepContinue: () {

                    if (_nameController.text.isNotEmpty
                        && _phoneController.text.isNotEmpty
                        && _edadController.text.isNotEmpty
                        && _cedulaController.text.isNotEmpty && (_selectedDate != null)){

                      FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).update({
                        'userPacientes': FieldValue.arrayUnion([
                          {
                            'nombre': _nameController.text.trim(),
                            'telefono': _phoneController.text.trim(),
                            'edad': _edadController.text.trim(),
                            'cedula': _cedulaController.text.trim(),
                            'fecha': _selectedDate,
                          }
                        ])

                      });

                      setState(() {

                      });
                      if(_activeStep<(stepList().length -1)) {
                        _activeStep += 1;
                      }
                    } else {
                      showDialog(context: context, builder: (context){
                        return AlertDialog(
                          content: SizedBox(
                              height: 80,
                              width: 100,
                              child: Center(
                                child: Text(
                                  'Llena los datos personales para continuar',
                                  style: GoogleFonts.montserrat(
                                    textStyle: Theme.of(context).textTheme.displayLarge,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),)),
                        );
                      });
                    }
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
