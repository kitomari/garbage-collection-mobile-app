import 'package:collection_app/common_widgets/edit_card.dart';
import 'package:collection_app/screens/home_screen/change_password.dart';
import 'package:collection_app/screens/home_screen/change_phone.dart';
import 'package:flutter/material.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Edit Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
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
              padding: const EdgeInsets.only(left: 10.0, top: 22, right: 10.0),
              child: Column(
                children: [
                  SizedBox(height: 15,),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/shedrackimage.jpg'),
                  ),
                  ListTile(
                    title: Text("Shedrack Kitomari", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
                    subtitle: Text("@kitomari",textAlign: TextAlign.center,),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditPhoneNumberScreen()));
                    },
                    child: EditCard(text: 'Change Phone number', icon: Icons.edit_outlined, color: Colors.black87)),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                    },
                    child: EditCard(text: 'Change Password', icon: Icons.edit_outlined, color: Colors.black87)),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}