// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:garbage_collection/src/common_widget/buttons.dart';
// import 'package:garbage_collection/src/common_widget/global_widget.dart';
// import 'package:garbage_collection/src/common_widget/input.dart';
// import 'package:garbage_collection/src/common_widget/ui_helpers.dart';
// import 'package:garbage_collection/src/config/api/request_method.dart';
// import 'package:garbage_collection/src/config/services/data_service.dart';
// import 'package:garbage_collection/src/constants/constant.dart';
// import 'package:garbage_collection/src/features/bottom_navigaion/bottom_navigation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   FocusNode focusEmail = FocusNode();
//   FocusNode focusPass = FocusNode();
//   var emailController = TextEditingController();
//   var passController = TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   String username = '';

//   // ignore: unused_field

//   bool _isObscure = true;

//   bool validateEmail(String value) {
//     bool emailValid = RegExp(
//             r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
//         .hasMatch(value);
//     return (value.isNotEmpty && emailValid) ? true : false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               UIHelper.verticalSpace(height: 30),
//               Center(
//                 child: Text(
//                   'Login',
//                   style: Theme.of(context).textTheme.headline2!.copyWith(),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(28.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Hey There!',
//                       style: Theme.of(context)
//                           .textTheme
//                           .headline2!
//                           .copyWith(color: Colors.grey),
//                     ),
//                     Text(
//                       "Welcome! it's time to protect our environment",
//                       style: Theme.of(context).textTheme.headline2!.copyWith(
//                           color: Colors.grey,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w400),
//                     ),
//                     UIHelper.verticalSpace(height: 20),
//                     Form(
//                       key: _formKey,
//                       child: Column(
//                         children: [
//                           UniversalInput(
//                             keyboardType: TextInputType.emailAddress,
//                             controller: emailController,
//                             fillColor: const Color(0xffD9D9D9),
//                             prefixIcon: Icons.email,
//                             filled: true,
//                             hint: "Email",
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(20.0),
//                               borderSide: const BorderSide(
//                                 color: Color(0xffD9D9D9),
//                                 width: 0.0,
//                               ),
//                             ),
//                             validator: (String? value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter your email';
//                               }
//                               return null;
//                             },
//                           ),
//                           UIHelper.verticalSpace(height: 20),
//                           UniversalInput(
//                             controller: passController,
//                             fillColor: const Color(0xffD9D9D9),
//                             filled: true,
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(20.0),
//                                 borderSide: const BorderSide(
//                                   color: Color(0xffD9D9D9),
//                                   width: 0.0,
//                                 )),
//                             validator: (String? value) {
//                               if (value!.isEmpty) {
//                                 return 'Please enter valid password';
//                               }
//                               return null;
//                             },
//                             prefixIcon: Icons.lock,
//                             obscure: _isObscure,
//                             isPassword: true,
//                             sufixWidget: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   _isObscure = !_isObscure;
//                                 });
//                               },
//                               icon: Icon(
//                                 _isObscure
//                                     ? Icons.visibility
//                                     : Icons.visibility_off,
//                               ),
//                             ),
//                             hint: 'Password',
//                           ),
//                           UIHelper.verticalSpace(height: 20),
//                           _submitButton()!,
//                           UIHelper.verticalSpace(height: 10),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text(
//                               'Forget Password',
//                               style: TextStyle(
//                                 fontSize: 16,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ),
//                           const Text(
//                             'OR',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           UIHelper.verticalSpace(height: 10),
//                           const Text(
//                             'Signin with social media',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                           UIHelper.verticalSpace(height: 15),
//                           Center(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 GestureDetector(
//                                   child: const Image(
//                                     image:
//                                         AssetImage('assets/images/google.png'),
//                                     height: 40,
//                                   ),
//                                 ),
//                                 UIHelper.horizontalSpace(width: 15),
//                                 GestureDetector(
//                                   child: const Image(
//                                     image: AssetImage('assets/images/fb.png'),
//                                     height: 40,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget? _submitButton() {
//     return UniversalButton(
//       radius: 30,
//       buttonHeight: 51,
//       action: () async {
//         if (_formKey.currentState!.validate()) {
//           universalLoading(context, content: 'Please wait...');
//           postLoginMethod(
//             email: emailController.text,
//             password: passController.text,
//           ).then((value) async {
//             if (value == "Connection closed before full header was received") {
//               Navigator.pop(context);
//               respondMessage(
//                 context,
//                 isSuccess: false,
//                 color: Theme.of(context).primaryColor,
//                 title: "Something wrong",
//                 subTitle: "please try angain to login",
//               );
//             } else {
//               if (value['code'] == 200) {
//                 log('=========j${value['code'].toString()}');

//                 var user = value['body']['user_data'][0];
//                 SharedPreferences prefs = await SharedPreferences.getInstance();
//                 Map<String, dynamic> userdata = {
//                   'name': user['names'],
//                   'email': user['email'],
//                   'contact': user['contact'],
//                   'username': user['username'],
//                   'roles': user['roles'],
//                   'status': user['status'],
//                   'date': user['date'],
//                   'id': user['id'],
//                 };
//                 String encodedMap = json.encode(userdata);
//                 prefs.setString('userdata', encodedMap);
//                 String datas = prefs.getString('userdata')!;
//                 Map<String, dynamic> decodedMap = json.decode(datas);
//                 setState(() {
//                   DataService.userData = decodedMap;
//                   userKey = 'authenticated';
//                 });
//                 Navigator.pop(context);
//                 passController.clear();
//                 emailController.clear();
//                 respondMessage(
//                   context,
//                   isSuccess: true,
//                   color: Theme.of(context).primaryColor,
//                   title: "Garbage Collection",
//                   subTitle: "Welcome back, and enjoy it...",
//                 );
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const BottomNav(),
//                   ),
//                 );
//               } else if (value['code'] == 401) {
//                 Navigator.pop(context);

//                 passController.clear();
//                 emailController.clear();
//                 respondMessage(
//                   context,
//                   isSuccess: false,
//                   color: Theme.of(context).primaryColor,
//                   title: "Unauthorized",
//                   subTitle: "Invalid email or password ",
//                 );
//               } else {
//                 passController.clear();
//                 emailController.clear();
//                 Navigator.pop(context);
//                 respondMessage(
//                   context,
//                   isSuccess: false,
//                   color: Theme.of(context).primaryColor,
//                   title: "Unsuccessully",
//                   subTitle: "Phone number or password is invalid",
//                 );
//               }
//             }
//           });
//         }
//       },
//       buttonColor: Theme.of(context).primaryColor,
//       child: const Text(
//         'Sign in',
//         style: TextStyle(
//           fontSize: 20,
//           fontFamily: 'Poppins',
//           fontWeight: FontWeight.w600,
//           color: Colors.white,
//         ),
//       ),
//       buttonWidth: UIHelper.deviceWidth(context) / 1.26,
//     );
//   }
// }
