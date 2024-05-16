import 'package:flutter/material.dart';

class AddBtn extends StatelessWidget {
  AddBtn({super.key, this.onTap});

  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade500,
          borderRadius: BorderRadius.circular(21), boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  blurRadius: 5,
                  spreadRadius: 5
              )
            ]
        ),
        child: const Icon(Icons.add, size: 70, color: Colors.white,),
      ),
    );
  }
}
