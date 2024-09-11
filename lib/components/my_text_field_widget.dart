import 'package:flutter/material.dart';

///
class my_txt_field extends StatelessWidget {
 final String? hintText;
 final TextEditingController? controller;
 final bool isobscureText;
  const my_txt_field({
    super.key,
    this.hintText,
    this.controller,
    required this.isobscureText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: TextField(
       obscureText: isobscureText,
       controller: controller, 
       decoration: InputDecoration(
       
       hintText: hintText,
       filled: true,
       fillColor: Colors.white,
       enabledBorder: OutlineInputBorder(
        
       ),
       focusedBorder: OutlineInputBorder(
       
       )
       ),
      ),
    );
  }
}