import 'package:collection_app/common_widgets/auth_button.dart';
import 'package:collection_app/common_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({ Key? key }) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPasswordController = new TextEditingController();

  TextEditingController newPasswordController = new TextEditingController();

  TextEditingController confirmPasswordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Change Password', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
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
                  CustomTextInpuField(controller: currentPasswordController, hintText: 'Current Password'),
                  SizedBox(height: 10,),
                  CustomTextInpuField(controller: newPasswordController, hintText: 'New Password'),
                  SizedBox(height: 10,),
                  CustomTextInpuField(controller: confirmPasswordController, hintText: 'Confirm Password'),
                  SizedBox(height: 10,),
                  // InfoButton(text: 'Submit', color: Colors.blue, onTap: (){})
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