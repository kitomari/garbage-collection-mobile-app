import 'dart:convert';
import 'package:collection_app/common_widgets/auth_button.dart';
import 'package:collection_app/common_widgets/text_field_input.dart';
import 'package:collection_app/services/add_collection_service.dart';
import 'package:collection_app/services/authentication_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

  DateTime now = DateTime.now();
  DateFormat format = DateFormat('yyyy-MM-dd');
  String formatted = format.format(now);

class CapturedQrScreen extends StatefulWidget {
  // final String qrCodes;
  final dynamic data;
  CapturedQrScreen({ Key? key, required this.data }) : super(key: key);

  @override
  State<CapturedQrScreen> createState() => _CapturedQrScreenState();
}

class _CapturedQrScreenState extends State<CapturedQrScreen> {
  final AuthenticateServices authServices = AuthenticateServices();

  final _scanFormKey = GlobalKey<FormState>();

  final TextEditingController _qrCodeController = TextEditingController();

  final TextEditingController _customerNameController = TextEditingController();

  final TextEditingController _businessNameController = TextEditingController();

  final TextEditingController _userController = TextEditingController();

  final TextEditingController _amountController = TextEditingController();



  final AddCollection collection = AddCollection();

    void addCollect(){
    print('wewe mto ${widget.data['qr_code']}');
    
    collection.addCollection(
      name: widget.data['name'], 
      category: widget.data['category'],
      qr_code: widget.data['qr_code'],
      amount: widget.data['amount'],
      user_id: widget.data['user_id'],
      date: formatted
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    _businessNameController.dispose();
    _customerNameController.dispose();
    _qrCodeController.dispose();
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('All dataz ${widget.data}');
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
                  key: _scanFormKey,
                  child: Column(
                    children: [
                      TextInpuField(
                        obscureText: false,
                        controller: TextEditingController(text: '${widget.data!['qr_code']}'), 
                        hintText: widget.data!['qr_code'],
                      ),
                      const SizedBox(height: 15),
                      TextInpuField(
                        obscureText: false,
                        // controller: _customerNameController, 
                        controller: TextEditingController(text: '${widget.data!['name']}'),
                        hintText: widget.data!['name'],
                      ), 
                      const SizedBox(height: 15),  
                      TextInpuField(
                        obscureText: false,
                        controller: TextEditingController(text: '${widget.data!['category']}'), 
                        hintText: widget.data!['category'],
                      ),
                      const SizedBox(height: 15), 
                      TextInpuField(
                        obscureText: false,
                        controller: TextEditingController(text: '${widget.data!['amount']}'), 
                        hintText: widget.data!['amount'],
                      ),
                      const SizedBox(height: 15), 
                      TextInpuField(
                        obscureText: false,
                        controller: TextEditingController(text: '${widget.data!['user_id']}'), 
                        hintText: widget.data!['user_id'],
                      ),         
                      const SizedBox(height: 15),
                      AuthenticationButton(
                        onTap: (){
                          if(_scanFormKey.currentState!.validate()){
                            addCollect();
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
    );
  }
}