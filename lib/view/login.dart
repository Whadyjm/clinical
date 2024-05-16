import 'package:clinical/view/inicio.dart';
import 'package:clinical/view/password.dart';
import 'package:clinical/view/registro.dart';
import 'package:clinical/widgets/textForm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late bool visiblePassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();

  void wrong() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: SizedBox(
            height: 80,
            width: 100,
            child: Center(
              child: Text(
              'Correo o contraseña incorrecta',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 150,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        'Clinical',
                        style: GoogleFonts.montserrat(
                          textStyle: Theme.of(context).textTheme.displayLarge,
                          fontSize: 80,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                      const Text('Historial clínico', style: TextStyle(fontSize: 18),),
                    ],
                  ),
                ),
                const SizedBox(height: 100,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextForm(
                    controller: emailController,
                    hint: 'Ingrese su correo electrónico',
                    icon: Icons.person_2_rounded,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Ingresa tu correo electrónico";
                        }else{
                          null;
                        }
                      },
                  fillColor: Colors.grey.shade300,),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Ingrese su contraseña',
                          prefixIcon: const Icon(Icons.lock),
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
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return const Password();
                  }));
                }, child: Text('¿Olvidaste tu contraseña?', style: TextStyle(color: Colors.grey.shade700),)),
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
                  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context){
                    return const Inicio();
                  }), (route) => false);
                } on FirebaseAuthException catch (e) {
                  Navigator.pop(context);
                  if (e.code == 'invalid-credential') {
                    wrong();
                  } else if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
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
                      'Ingresar',
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
                      const Text('¿No posees cuenta?'),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return const Registro();},
                            ),
                            );
                          },
                          child: Text('Regístrate',
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
