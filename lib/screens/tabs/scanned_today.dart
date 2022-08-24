import 'dart:convert';

import 'package:collection_app/common_widgets/history_card.dart';
import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/constants/main_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScannedToday extends StatefulWidget {
  const ScannedToday({ Key? key }) : super(key: key);

  @override
  State<ScannedToday> createState() => _ScannedTodayState();
}

class _ScannedTodayState extends State<ScannedToday> {

  List<dynamic> _todayCustomers = [];

    
  Future<void> viewTodayCustomer() async{
    http.Response response = await http.post(
      Uri.parse('$uri/api/view_all_scanned.php'), 
      body: jsonEncode({'user_id': DataServices.userInfo!['id']}),
      headers: {'Content-Type': 'application/json'});

      print("ID ni ${DataServices.userInfo!['id']}");
      print("Data zotez ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        var allDataz = data['data'];
        setState(() {
          _todayCustomers = allDataz;
        });
      }
  }

  @override
  void initState() {
    viewTodayCustomer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Expanded(
              child: Container(
              height: 370,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 5,),
                  Expanded(
                      child: _todayCustomers.isEmpty ? Column(
                        children: [
                            SizedBox(height: 10,),
                            Center(
                              child: Image(image: AssetImage('assets/images/user5.png')),
                            ),
                            SizedBox(height: 20,),
                            Text('No scanned QR today'),
                            SizedBox(height: 20,),
                        ],
                      )
                       : ListView.builder(
                          shrinkWrap: true,
                          itemCount: _todayCustomers.length,
                          itemBuilder: (BuildContext context, int index) {
                              return HistoryCard(
                                icon: Icon(Icons.qr_code), 
                                arrowIcon: Icon(Icons.arrow_forward_ios_outlined), 
                                action: (){}, 
                                nameText: _todayCustomers[index]['name'], 
                                typeText: _todayCustomers[index]['category'],
                              );
                          }
                      ),
                  )
              ]
              )
            ),
    );
  }
}