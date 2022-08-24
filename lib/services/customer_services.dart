
import 'dart:convert';
import 'dart:developer';

import 'package:collection_app/constants/data_services.dart';
import 'package:collection_app/constants/main_url.dart';
import 'package:collection_app/models/customer_model.dart';
import 'package:http/http.dart' as http;

Future<CustomerModel?> getRegisteredCustomers() async{
  CustomerModel? result;
  try{
    final response = await http.post(
      Uri.parse('$uri/api/view_customer.php'),
      body: jsonEncode({'user_id': DataServices.userInfo!['id']}),
      headers: <String, String>{'Content-Type': 'application/json'}
    );
    if(response.statusCode == 200){
      final item = jsonDecode(response.body);
      result = CustomerModel.fromJson(item);
    }else{
      print("error");
    }
  }catch(e){
    log(e.toString());
  }
  return result;
}