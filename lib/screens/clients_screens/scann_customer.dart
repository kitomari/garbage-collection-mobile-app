
import 'package:collection_app/common_widgets/auth_button.dart';
import 'package:collection_app/common_widgets/text_field_input.dart';
import 'package:collection_app/services/authentication_services.dart';
import 'package:flutter/material.dart';

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