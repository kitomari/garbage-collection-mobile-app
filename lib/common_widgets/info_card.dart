import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({ Key? key, required this.text, required this.icon, required this.color, }) : super(key: key);

  //The values we need
  final String text;
  final IconData icon;
  final Color color;
  // final ShapeBorder shape;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white38, width: 1),
          borderRadius: BorderRadius.circular(12)
      ),
      // shape: shape,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      child: ListTile(
        leading: Icon(icon),
        title: Text(text, style: TextStyle(
          color: color,
          fontSize: 18,
        ),),
      ),
    );
  }
}