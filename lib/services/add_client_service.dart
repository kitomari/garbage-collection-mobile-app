import 'dart:convert';

import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/constants/main_url.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddCustomer{

  Future<Map<String,dynamic>> addCustomer({required String name,required String hno, required String mobile, required String street, required String district, required String region, required String qr_code, required String category, required String amount, required String user_id}) async{
    try{
      // print('$qr_code');
      // print('$name');
      // print('$hno');
      // print('$mobile');
      // print('$street');
      // print('$district');
      // print('$region');
      // print('$category');
      // print('$user_id');
      // print('$amount');
      http.Response response = await http.post(
        Uri.parse('$uri/api/add_customer.php'),
        body: jsonEncode({'name': name, 'hno': hno, 'mobile': mobile, 'street': street, 'district': district, 'region': region, 'qr_code': qr_code, 'category': category, 'amount': amount, 'user_id': DataServices.userInfo!['id']}),
        headers: <String, String>{'Content-Type': 'application/json;charset=UTF-8'}
      );
      print("Dataz ${response.body}");
      if(response.statusCode == 200){
        final customerData = jsonDecode(response.body);
        print('Zinaendaaaaa');
        return customerData;
      }else{
        return {};
      }
    }catch(e){
      throw e;
    }
  }

  static Future<Map<String, dynamic>> viewAllCustomer() async{
    try{
      http.Response response = await http.post(
        Uri.parse('$uri/api/view_customer.php'),
        body: jsonEncode({'user_id': DataServices.userInfo!['id']}),
        headers: <String, String>{'Content-Type': 'application/json'}
      );
      print("Data hizooo ${response.body}");
      if(response.statusCode == 200){

        final allCustomer = jsonDecode(response.body);
        var homeData = allCustomer['data'];
        return homeData;
      }
      return {};
    }catch(e){
      throw e;
    }
  }
}