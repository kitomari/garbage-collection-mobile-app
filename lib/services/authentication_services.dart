import 'dart:convert';
import 'package:collection_app/constants/main_url.dart';
import 'package:collection_app/providers/user_provider.dart';
import 'package:collection_app/screens/bottom_bar.dart';
import 'package:collection_app/utilits/handle_error.dart';
import 'package:collection_app/utilits/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// User user;
class AuthenticateServices{
  void loginToDB({required BuildContext context, required String email, required String password}) async{
    try {
      
      http.Response respo = await http.post(
        Uri.parse('$uri/api/login.php'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'}
      );
      print(respo.body);

      if(respo.statusCode == 200){
        final userData = jsonDecode(respo.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        Map<String, dynamic> userInfo = {
          'id': userData['user_data'][0]['id'],
          'names': userData['user_data'][0]['names'],
          'email': userData['user_data'][0]['email'],
          'username': userData['user_data'][0]['username'],
          'contact': userData['user_data'][0]['contact'],
          'roles': userData['user_data'][0]['roles'],
          'dates': userData['user_data'][0]['dates'],
          'status': userData['user_data'][0]['status'],
        };

        String encodedMapData = jsonEncode(userInfo);
        prefs.setString('userInfo', encodedMapData);

        String data = prefs.getString('userInfo')!;
        Map<String, dynamic> decodedMapData = jsonDecode(data);

        // setState((){});
        // DataServices.userData = decodedMapData;
        String? jina = prefs.getString('username');
        print(jina);
      }
      httpErrorHandle(
        response: respo, 
        context: context, 
        onSuccess: ()async{
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(respo.body);
          // await prefs.setString('is-logged-in', jsonDecode(respo.body)['email']);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomBar()));
        });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async{
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? email = prefs.getString('is-logged-in');
      if(email == null){
        prefs.setString('is-logged-in', '');
      }
    } catch (e) {
    }
  }
}