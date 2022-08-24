import 'package:collection_app/common_widgets/history_card.dart';
import 'package:flutter/material.dart';

class AllScanned extends StatefulWidget {
  const AllScanned({ Key? key }) : super(key: key);

  @override
  State<AllScanned> createState() => _AllScannedState();
}

class _AllScannedState extends State<AllScanned> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
              child: Container(
              height: 370,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5,),
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                              return HistoryCard(icon: Icon(Icons.qr_code), arrowIcon: Icon(Icons.arrow_forward_ios_outlined), action: (){}, nameText: "Shedrack Kitomari", typeText: "Waste Collection",);
                          }
                      ),
                  )
              ]
              )
            ),
    );
  }
}