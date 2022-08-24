import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const AuthenticationButton({ Key? key, required this.onTap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        primary: Colors.blueAccent[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        minimumSize: const Size(double.infinity, 55)
      ),
    );
  }
}