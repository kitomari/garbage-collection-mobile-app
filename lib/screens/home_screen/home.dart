import 'dart:convert';

import 'package:collection_app/common_widgets/activities_card.dart';
import 'package:collection_app/common_widgets/history_card.dart';
import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/constants/main_url.dart';
import 'package:http/http.dart' as http;
import 'package:collection_app/screens/clients_screens/scan_qr_to_add.dart';
import 'package:collection_app/screens/clients_screens/scan_qr_to_register.dart';
import 'package:collection_app/screens/home_screen/history_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    bool _isReloading = false;
    
  Future<void> viewAllCustomer() async{
    http.Response response = await http.post(
      Uri.parse('$uri/api/view_customer.php'), 
      body: jsonEncode({'user_id': DataServices.userInfo!['id']}),
      headers: {'Content-Type': 'application/json'});

      print("IDs ni ${DataServices.userInfo!['id']}");
      print("Data zotez ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        var allDataz = data['data'];
        setState(() {
          // _allCustomers = allDataz;
          DataServices.viewClient = allDataz;
        });
      }
  }

  Future<void>_reloadData() async{
    setState(() {
      _isReloading = true;
    });
    await DataServices.viewClient != null;
    setState(() {
      _isReloading = false;
    });
  }

  @override
  void initState() {
    DataServices.userInfo;
    DataServices.viewClient;
    viewAllCustomer();
    // fetchID();
    _isReloading = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    print("Zipo ngapi? ${DataServices.viewClient!.length}");
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: RefreshIndicator(
        onRefresh: _reloadData,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18.0, top: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome! ${DataServices.userInfo!['names']}',  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                    SizedBox(height: 5,),
                    Text('Lets start scanning', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.white),)
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 42,
                margin: const EdgeInsets.only(left: 18, right: 15, bottom: 10),
                child: Material(
                  borderRadius: BorderRadius.circular(15),
                  elevation: 1,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                        onTap: (){},
                        child:  const Padding(padding: EdgeInsets.only(left: 6),
                        child: Icon(Icons.search, color: Colors.black, size: 23,),
                        ),
                      ),
                      hintMaxLines: 2,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(top: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)
                        ),
                        borderSide: BorderSide.none 
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)
                        ),
                        borderSide: BorderSide(color: Colors.black38, width: 1) 
                      ),
                      hintText: 'Search...',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      )
                    ),
                  ),
                )
              ),
              const SizedBox(height: 30,),
              Expanded(
                // ignore: sized_box_for_whitespace
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35))
                  ),
        
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 22, right: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Activities", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ActivityCard(
                              icon: const Icon(Icons.qr_code_2_outlined, size: 50,), 
                              action: (){
                                // print('weweee');
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => QrCodeScanner()));
                              }, 
                              text: 'Scan QR'
                            ),
                            ActivityCard(
                              icon: const Icon(Icons.person_add, size: 50,), 
                              action: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => QrCodeScannerRegister()));
                              }, 
                              text: 'Add Client'
                            ),
                            ActivityCard(
                              icon: const Icon(Icons.history_edu_outlined, size: 50,), 
                              action: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => HistoryScreen()));
                              }, 
                              text: 'View History'
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          height: 70,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            elevation: 3,
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              // side: const BorderSide(color: Color(0xFF000000))
                               side: const BorderSide(color: Colors.white38, width: 2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: const [
                                      Text("30", style: TextStyle(fontSize: 22),),
                                      Text("Scanned", style: TextStyle(fontSize: 22),)
                                    ],
                                  ),
                                  Column(
                                    children: const [
                                      Text("48,000/=", style: TextStyle(fontSize: 22),),
                                      Text("Revenue", style: TextStyle(fontSize: 22),)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            
                          ),
                        ),
                        const SizedBox(height: 10,),
                        const Text('Recent Scanned', style: TextStyle(fontSize: 20),),
                        const SizedBox(height: 10,),
                        Expanded(
                          child: Container(
                          height: 370,
                          child: Column(children: <Widget>[
                              Expanded(
                                  child: DataServices.viewClient == null ? CircularProgressIndicator():ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: DataServices.viewClient!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                          return HistoryCard(
                                            icon: Icon(Icons.qr_code), 
                                            arrowIcon: Icon(Icons.arrow_forward_ios_outlined), 
                                            action: (){}, 
                                            nameText: DataServices.viewClient![index]['name'], 
                                            typeText: DataServices.viewClient![index]['mobile'],);
                                      }
                                  ),
                              )
                          ]
                          )),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
        
          ),
        ),
      ),
    );
  }
}