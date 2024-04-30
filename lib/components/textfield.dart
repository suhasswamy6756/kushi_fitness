// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget{
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final bool readOnly;
  final Color hintColor;


  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.controller,
    required this.readOnly,
    required this.hintColor,

  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        readOnly: readOnly,
        obscureText: obscureText,
        controller: controller,

        decoration: InputDecoration(

          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          fillColor: Colors.white,
          filled:true,
          hintText: hintText,

          hintStyle:  TextStyle(color: hintColor),



        ),
      ),
    );

  }
}