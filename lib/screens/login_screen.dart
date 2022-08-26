
import 'dart:convert';

import 'package:collection_app/common_widgets/auth_button.dart';
import 'package:collection_app/common_widgets/text_field_input.dart';
import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/constants/main_url.dart';
import 'package:collection_app/screens/bottom_bar.dart';
import 'package:collection_app/utilits/handle_error.dart';
import 'package:collection_app/utilits/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // final AuthenticateServices authServices = AuthenticateServices();
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


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

        print(decodedMapData);

        setState((){
          DataServices.userInfo = decodedMapData;
        });
        // DataServices.userData = decodedMapData;
        print("Data za Shared ${DataServices.userInfo}");
        print("Data za Shared ID ${DataServices.userInfo!['id']}");
        String? jina = prefs.getString(DataServices.userInfo!['names']);
        print(jina);
      }
      httpErrorHandle(
        response: respo, 
        context: context, 
        onSuccess: ()async{
          Navigator.push(context, MaterialPageRoute(builder: (context) => const BottomBar()));
        });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
    loginUser(){
    loginToDB(
      context: context, 
      email: _emailController.text, 
      password: _passwordController.text,
    );
  }

  //Method to display progress indicator
  showLoaderDialog(BuildContext context){
    AlertDialog alert = new AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7), child: Text("Loging in...."),)
        ],
      ),
    );
    showDialog(context: context, builder: (BuildContext context){
      return alert;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(child: Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),)),
                const SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Hey there!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),),
                      Text('Welcome its time to protect our environment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Colors.grey),)
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(18),
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        TextInpuField(
                          obscureText: false,
                          controller: _emailController, 
                          hintText: 'Email'
                        ),
                        const SizedBox(height: 20),
                        TextInpuField(
                          obscureText: true,
                          controller: _passwordController, 
                          hintText: 'Password'
                        ),
                        const SizedBox(height: 20),
                        AuthenticationButton(
                          onTap: () async{
                            // print('weweee');
                            showLoaderDialog(context);
                            if(_loginFormKey.currentState!.validate()){
                              loginUser();
                              // print('is validating');
                            }
                            Navigator.pop(context);
                          }, 
                          text: 'Sign in',
                        ),
                        const SizedBox(height: 25),
                        const SizedBox(
                          child: Text('Forgot password?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey),),
                        )
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