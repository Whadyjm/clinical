import 'package:clinical/view/formulario.dart';
import 'package:clinical/widgets/menuBtn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/addBtn.dart';
import '../widgets/menuDialog.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MenuBtn(
                      onTap: () {
                        showDialog(context: (context), builder: (context){
                          return MenuDialog();
                        });
                      },
                    ),
                    Text(
                      '${auth.currentUser!.displayName}',
                      style: GoogleFonts.montserrat(
                        textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                    ),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(height: 60, '${auth.currentUser!.photoURL}'))
                  ],
                ),
              ),
              const SizedBox(height: 300,),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Aún no has agregado pacientes a tu lista',
                    style: GoogleFonts.montserrat(
                      textStyle: Theme.of(context).textTheme.displayLarge,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              AddBtn(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Formulario();
                  }));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
