import 'dart:convert';

import 'package:clinical/view/inicio.dart';
import 'package:clinical/view/login.dart';
import 'package:clinical/widgets/textForm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/image_picker_widget.dart';

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {

  late bool visiblePassword = true;
  late bool genero = true;

  List<String> DropdownList = [
    'Odontología General',
    'Odontopediatría',
    'Periodoncia',
    'Prostodoncia',
    'Endodoncia',
    'Ortodoncia',
    'Cirugía Bucal',
    'Cirugía Maxilofacial',
    'Implantología',
    'Restauración',
  ];

  List<DropdownMenuItem<String>>? get DropDownList {
    List<DropdownMenuItem<String>>? menuItem =
    List<DropdownMenuItem<String>>.generate(
      DropdownList.length,
          (index) => DropdownMenuItem(
        value: DropdownList[index],
        child: Text(DropdownList[index]),
      ),
    );
    return menuItem;
  }

  void weakPassword() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: SizedBox(
            height: 80,
            width: 100,
            child: Center(
              child: Text(
                'La contraseña establecida es my débil',
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

  void usedAccount() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: SizedBox(
            height: 80,
            width: 100,
            child: Center(
              child: Text(
                'Ya existe una cuenta asociada a este correo electrónico',
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

  bool visible = true;
  String? _value;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final formKey = GlobalKey<FormState>();

  XFile? _pickedImage;

  String base64String = '';
  Future<void> galeriaPicker() async {
    final ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    Uint8List _bytes = await _pickedImage!.readAsBytes();

    String _base64String = base64.encode(_bytes);
    setState(() {base64String = _base64String;});
  }

  String? userImageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                      Navigator.pop(context);
                      },
                        icon: const Icon(Icons.arrow_back_ios_rounded,)),
                  ],
                ),
                const SizedBox(height: 60,),
                SizedBox(
                    height: 100,
                    width: 100,
                    child: ImagePickerWidget(
                      imagedPicked: _pickedImage,
                      function: (){
                        galeriaPicker();
                      },)),
                const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextForm(
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    hint: 'Ingresa tu nombre y apellido',
                      validator: (value){
                        if(value!.isEmpty){
                          return "Ingresa tu nombre y apellido";
                        }else{
                          null;
                        }
                      },
                    fillColor: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextForm(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    hint: 'Ingresa tu correo electrónico',
                      validator: (value){
                        if(value!.isEmpty){
                          return "Ingresa tu correo electrónico";
                        }else{
                          null;
                        }
                      },
                    fillColor: Colors.grey.shade300,
                  ),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextForm(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    hint: 'Ingresa tu número telefónico',
                      validator: (value){
                        if(value!.isEmpty){
                          return "Ingresa tu número telefónico";
                        }else{
                          null;
                        }
                      },
                    fillColor: Colors.grey.shade300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: visiblePassword,
                      decoration: InputDecoration(
                          hintText: 'Ingrese su contraseña',
                          //prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visiblePassword = !visiblePassword;
                              });
                            },
                            icon: Icon(visiblePassword ? Icons.visibility_rounded:Icons.visibility_off_rounded
                            ),
                          ),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade300
                      ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Ingresa tu contraseña";
                          }else{
                            null;
                          }
                        }
                    ),
                  ),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 350,
                    child: DropdownButtonFormField(
                        decoration: InputDecoration(
                            hintText: "Selecciona tu especialidad",
                            hintStyle: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.normal),
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25)
                            )
                        ),
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        items: DropDownList,
                        value: _value,
                        onChanged: (String? value) {
                          setState(() {
                            _value = value;
                          });
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return "Ingresa tu especialidad";
                          }else{
                            null;
                          }
                        }
                        ),
                  ),
                ),
                const SizedBox(height: 50,),
                GestureDetector(
                  onTap: () async {

                    showDialog(context: context, builder: (context){
                      return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ));
                    });

                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                      );

                      final ref = FirebaseStorage.instance.ref().child('usersImages').child('${emailController.text.trim()}.jpg');

                      Uint8List image = Base64Codec().decode(base64String);
                      await ref.putData(image, SettableMetadata(contentType: 'image/jpg'));
                      userImageUrl = await ref.getDownloadURL();

                      final User? user = auth.currentUser;
                      user!.updateDisplayName(nameController.text.trim());
                      user.updatePhotoURL(userImageUrl);
                      user.reload();

                      await firestore.collection('users').doc(user.uid).set({
                        'uid': user.uid,
                        'userImage': userImageUrl,
                        'name': nameController.text.trim(),
                        'email': emailController.text.trim(),
                        'phone': phoneController.text.trim(),
                        'password': passwordController.text.trim(),
                        'especialidad': _value,
                      }
                      );

                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                        return Inicio();
                      }), (route) => false);
                    } on FirebaseAuthException catch (e) {
                      Navigator.pop(context);
                      if (e.code == 'weak-password') {
                        weakPassword();
                      } else if (e.code == 'email-already-in-use') {
                        usedAccount();
                      } else if (formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      print(e);
                    }

                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(21), boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          blurRadius: 2,
                          spreadRadius: 2
                      )
                    ]
                    ),
                    child: const Center(
                        child:
                        Text(
                          'Registrar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21),
                        )
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('¿Ya posees cuenta?'),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return Login();
                            }));
                          },
                          child: Text('Inicia Sesión',
                            style:
                            TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 18 ,color: Colors.grey.shade700),)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
