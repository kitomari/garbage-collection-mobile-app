import 'package:collection_app/common_widgets/info_card.dart';
import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/screens/home_screen/edit_profile.dart';
import 'package:collection_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({ Key? key }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  removeUserInfo() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(DataServices.userInfo!['email']);
    setState(() {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route)=>false);
    });
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
              dividerTheme: DividerThemeData(
                color: Colors.black54
              )
            ),
            child: PopupMenuButton<int>(
              // color: Colors.black,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold),),
                  value: 1,
                ),
                PopupMenuDivider(),
                PopupMenuItem(
                  child: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold),),
                  onTap: (){
                    removeUserInfo();
                  },
                  value: 1,
                ),
              ]
            ),
          )
        ],
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
                    title: Text("${DataServices.userInfo!['names']}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,), textAlign: TextAlign.center,),
                    subtitle: Text("${DataServices.userInfo!['username']}",textAlign: TextAlign.center,),
                  ),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileEditScreen()));
                    }, 
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                    ),
                    child: Text('Edit Profile'),
                  ),
                  InfoCard(text: '${DataServices.userInfo!['email']}', icon: Icons.email, color: Colors.black87,),
                  InfoCard(text: '${DataServices.userInfo!['contact']}', icon: Icons.phone, color: Colors.black87),
                  InfoCard(text: 'Agent: 2038', icon: Icons.verified,color: Colors.black87),
                  InfoCard(text: 'Date joined: 03 Aug 2022', icon: Icons.calendar_today_outlined,color: Colors.black87),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}