import 'dart:convert';
import 'package:collection_app/common_widgets/auth_button.dart';
import 'package:collection_app/common_widgets/history_card.dart';
import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/constants/main_url.dart';
import 'package:collection_app/screens/clients_screens/scan_qr_to_register.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({ Key? key }) : super(key: key);

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {

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
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        automaticallyImplyLeading: false,
        title: Text("Clients", style: TextStyle(color: Colors.black, fontSize: 24),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _reloadData,
        child: SafeArea(
          child: Container(
            child: DataServices.viewClient == null ? Column(
              children: [
                SizedBox(height: 10,),
                Center(
                  child: Image(image: AssetImage('assets/images/user5.png')),
                ),
                SizedBox(height: 20,),
                Text('Add new client here'),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(right: 40, left: 40, top: 30),
                  child: AuthenticationButton(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => QrCodeScannerRegister()));
                    }, 
                    text: 'Add Client'
                  ),
                )
                // ElevatedButton(
                //   onPressed: viewAllCustomer, 
                //   child: Text('Load Datas'))
              ],
            )
            : ListView.builder(
              itemCount: DataServices.viewClient!.length,
              itemBuilder: (BuildContext context, index){
                return HistoryCard(icon: Icon(Icons.qr_code), arrowIcon: Icon(Icons.arrow_forward_ios_outlined), action: (){}, nameText: DataServices.viewClient![index]['name'], typeText: DataServices.viewClient![index]['mobile'],);
              }),
          ),
        ),
      )
    );
  }
}