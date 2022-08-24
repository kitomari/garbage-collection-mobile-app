
import 'dart:convert';

import 'package:collection_app/common_widgets/auth_button.dart';
import 'package:collection_app/common_widgets/text_field_input.dart';
import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/constants/main_url.dart';
import 'package:collection_app/services/add_client_service.dart';
import 'package:collection_app/services/add_collection_service.dart';
import 'package:collection_app/services/authentication_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CapturedQrScreen extends StatelessWidget {
  final String qrCodes;
  CapturedQrScreen({ Key? key, required this.qrCodes }) : super(key: key);

  final AuthenticateServices authServices = AuthenticateServices();
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _qrCodeController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  //  AddCollection customerCollection = new AddCollection();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Details", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
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
                        controller: _qrCodeController, 
                        hintText: '${qrCodes}'
                      ),
                      const SizedBox(height: 15),
                      TextInpuField(
                        obscureText: false,
                        controller: _customerNameController, 
                        hintText: ''
                      ), 
                      const SizedBox(height: 15),  
                      TextInpuField(
                        obscureText: false,
                        controller: _businessNameController, 
                        hintText: 'Mini Supermarket'
                      ),
                      const SizedBox(height: 15), 
                      TextInpuField(
                        obscureText: false,
                        controller: _contactController, 
                        hintText: '0756347067'
                      ),
                      const SizedBox(height: 15), 
                      TextInpuField(
                        obscureText: false,
                        controller: _amountController, 
                        hintText: '20,000'
                      ),         
                      const SizedBox(height: 15),
                      AuthenticationButton(
                        onTap: (){
                          // print('weweee');
                          // if(_loginFormKey.currentState!.validate()){
                          //   loginUser();
                          //   // print('is validating');
                          // }
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
    );
  }
}