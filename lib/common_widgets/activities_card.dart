
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback action;
  const ActivityCard({ Key? key, required this.icon , required this.action, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: [
                icon,
                const SizedBox(height: 5,),
                Text(text)
              ],
            ),
          ),
          onTap: action,
        ),
        color: Colors.blue[200],
      ),
    );
  }
}