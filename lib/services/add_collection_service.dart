import 'dart:convert';

import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/constants/main_url.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

  final DateTime now = DateTime.now();
  final DateFormat format = DateFormat('yyyy-MM-dd');
  final String formatted = format.format(now);

class AddCollection{


  Future<void> compareQrCode({required String qr_code}) async{
    http.Response response = await http.post(
      Uri.parse('$uri/api/compareQrCode.php'), 
      body: jsonEncode({'qr_code': qr_code}),
      headers: {'Content-Type': 'application/json'});

      print("Data zotez ${response.body}");
      if(response.statusCode == 200){
        final data = jsonDecode(response.body);
        var allDataz = data['data'];

        if(allDataz != null){
          DataServices.qrInfo = allDataz;
        }else{
          return  null;
        }
        // return qrInfo;
      }
  }

  Future<Map<String,dynamic>> addCollection({required String name, required String qr_code,required String category, required String amount, required String user_id,  required String date}) async{
    try{
      // print('$qr_code');
      // print('$name');
      // print('$category');
      // print('$user_id');
      // print('$amount');
      http.Response response = await http.post(
        Uri.parse('$uri/api/add_collection.php'),
        body: jsonEncode({'name': name, 'qr_code': qr_code, 'category': category, 'amount': amount, 'user_id': DataServices.userInfo!['id'], 'date': formatted}),
        headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'}
      );
      print("Dataz ${response.body}");
      if(response.statusCode == 200){
        final customerData = jsonDecode(response.body);
        print('Kaskaniwaa');
        return customerData;
      }else{
        return {};
      }
    }catch(e){
      throw e;
    }
  }

  // static Future<Map<String, dynamic>> viewAllCustomer() async{
  //   try{
  //     http.Response response = await http.post(
  //       Uri.parse('$uri/api/view_customer.php'),
  //       body: jsonEncode({'user_id': DataServices.userInfo!['id']}),
  //       headers: <String, String>{'Content-Type': 'application/json'}
  //     );
  //     print("Data hizooo ${response.body}");
  //     if(response.statusCode == 200){

  //       final allCustomer = jsonDecode(response.body);
  //       var homeData = allCustomer['data'];
  //       return homeData;
  //     }
  //     return {};
  //   }catch(e){
  //     throw e;
  //   }
  // }
}