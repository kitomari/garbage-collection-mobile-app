import 'package:flutter/material.dart';

class ActivitiyCard extends StatefulWidget {
  final String hintText;
  final Widget icon;
  final VoidCallback onTap;
  const ActivitiyCard({ Key? key, required this.hintText, required this.icon, required this.onTap}) : super(key: key);

  @override
  State<ActivitiyCard> createState() => _ActivitiyCardState();
}

class _ActivitiyCardState extends State<ActivitiyCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(12)
        ),
          child: const Icon(Icons.ac_unit),
        ),
        onTap: (){},
    );
  }
}