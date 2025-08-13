import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? fun;
  const MyTextButton({
    super.key, required this.text, required this.icon,this.fun
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed:fun,
    child:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         
          Icon(icon, size: 30, color: Colors.blue),
          Text('$text', style: TextStyle(fontSize: 18)),
       
      ],
    ),
     
    );
  }
}