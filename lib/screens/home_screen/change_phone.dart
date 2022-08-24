import 'package:collection_app/common_widgets/auth_button.dart';
import 'package:collection_app/common_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class EditPhoneNumberScreen extends StatefulWidget {
  const EditPhoneNumberScreen({ Key? key }) : super(key: key);

  @override
  State<EditPhoneNumberScreen> createState() => _EditPhoneNumberScreenState();
}

class _EditPhoneNumberScreenState extends State<EditPhoneNumberScreen> {
  TextEditingController newNumberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Change Number', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
              child: Column(
                children: [
                  CustomTextInpuField(controller: newNumberController, hintText: 'New number'),
                  SizedBox(height: 10,),
                  AuthenticationButton(onTap: (){}, text: 'Submit')
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}