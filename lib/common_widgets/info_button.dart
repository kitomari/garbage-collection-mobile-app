import 'package:flutter/material.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({ Key? key, required this.text, required this.color, required this.onTap }) : super(key: key);

  //The values we need
  final String text;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        color: color,
        shape: RoundedRectangleBorder(
            // side: const BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(12)
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ListTile(
          // leading: Icon(icon),
          title: Text(text, style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}