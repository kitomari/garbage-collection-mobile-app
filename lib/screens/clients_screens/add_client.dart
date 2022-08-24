// import 'dart:js';

import 'package:collection_app/common_widgets/auth_button.dart';
import 'package:collection_app/common_widgets/text_field_input.dart';
import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/services/add_client_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddClientScreen extends StatefulWidget {
  final String qrCodes;
  AddClientScreen({ Key? key, required this.qrCodes }) : super(key: key);

  @override
  State<AddClientScreen> createState() => _AddClientScreenState();
}

class _AddClientScreenState extends State<AddClientScreen> {

  // final String qrCodes;
  // _AddClientScreenState(this.qrCodes);
  final _registerFormKey = GlobalKey<FormState>();

  final TextEditingController _qrCodeController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _businessTypeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _regionController = TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _userController = TextEditingController();

  String? user_id;



  AddCustomer newCustomer = new AddCustomer();

    getUserId() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String user_id = prefs.getString('id') ?? '';
      return user_id;
    }

    @override
  void initState(){
    getUserId();
    super.initState();
  }

  void addClient(){
    print('wewe mtoto');
    newCustomer.addCustomer(
      qr_code: widget.qrCodes, 
      name: _customerNameController.text, 
      hno: _houseNumberController.text, 
      mobile: _phoneController.text, 
      street: _streetController.text, 
      district: _districtController.text, 
      region: _regionController.text, 
      category: _businessTypeController.text,
      amount: _priceController.text,
      user_id: DataServices.userInfo![0]['id'], 
    );
  }

  @override
  void dispose(){
    _qrCodeController.dispose();
    _customerNameController.dispose();
    _houseNumberController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _districtController.dispose();
    _regionController.dispose();
    _businessTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Client", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  child: Form(
                    key: _registerFormKey,
                    child: Column(
                      children: [
                        TextInpuField(
                          obscureText: false,
                          // controller: widget.qrCodes, 
                          controller: TextEditingController(text: '${widget.qrCodes}'),
                          hintText: 'Scanned QR codes'
                        ),
                        const SizedBox(height: 15),
                        TextInpuField(
                          obscureText: false,
                          controller: _customerNameController, 
                          hintText: 'Customer Name'
                        ),
                        const SizedBox(height: 15),
                        TextInpuField(
                          obscureText: false,
                          controller: _businessTypeController, 
                          hintText: 'Business name/type'
                        ),
                        const SizedBox(height: 15),
                        TextInpuField(
                          obscureText: false,
                          controller: _phoneController, 
                          hintText: 'Mobile number'
                        ),
                        const SizedBox(height: 15),
                        TextInpuField(
                          obscureText: false,
                          controller: _streetController, 
                          hintText: 'Street'
                        ),
                        const SizedBox(height: 15),
                        TextInpuField(
                          obscureText: false,
                          controller: _districtController, 
                          hintText: 'District'
                        ),
                        const SizedBox(height: 15),
                        TextInpuField(
                          obscureText: false,
                          controller: _regionController, 
                          hintText: 'Region'
                        ),
                        const SizedBox(height: 15),
                        TextInpuField(
                          obscureText: false,
                          controller: _houseNumberController, 
                          hintText: 'House number'
                        ),
                        const SizedBox(height: 15),
                        TextInpuField(
                          obscureText: false,
                          controller: _priceController, 
                          hintText: 'Set price'
                        ),
                        const SizedBox(height: 15),
                        AuthenticationButton(
                          onTap: (){
                            print('weweee');
                            if(_registerFormKey.currentState!.validate()){
                              addClient();
                              // sajiliClient();
                              print('is validated');
                            }
                          }, 
                          text: 'Submit',
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
          ),
      ),
    );
  }
}