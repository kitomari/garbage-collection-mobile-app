
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final Icon icon;
  final Icon arrowIcon;
  final String nameText;
  final String typeText;
  final VoidCallback action;
  const HistoryCard({ Key? key, required this.icon , required this.action, required this.nameText, required this.typeText, required this.arrowIcon}) : super(key: key);

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
                ListTile(
                  trailing: arrowIcon,
                  leading: icon,
                  title: Text(nameText),
                  subtitle: Text(typeText)
                )
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