import 'package:flutter/material.dart';

class MenuBtn extends StatelessWidget {
  MenuBtn({super.key, required this.onTap});

  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 5,
              spreadRadius: 5
            )
          ]
        ),
        child: const Icon(Icons.menu_rounded, color: Colors.black54,),
      ),
    );
  }
}
