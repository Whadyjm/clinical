import 'package:clinical/widgets/textForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },),
      ),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Text(
                'Recupera tu contraseña',
                style: GoogleFonts.montserrat(
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                ),
              ),
              const SizedBox(height: 50,),
              SizedBox(
                width: 350,
                child: TextForm(
                  controller: emailController,
                  hint: 'Ingresa tu correo electrónico',
                    validator: (value){
                      if(value!.isEmpty){
                        return "Ingresa tu correo electrónico";
                      }else{
                        null;
                      }
                    }
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 3),
                          elevation: 10,
                          content: const Center(
                            child: Text('Enlace enviado a tu correo',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),),
                          ),
                          backgroundColor: Colors.grey.shade700,));

                    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
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
                        'Recuperar',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21),
                      )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
