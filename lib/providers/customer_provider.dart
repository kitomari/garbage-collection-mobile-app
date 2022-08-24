
import 'package:collection_app/models/customer_model.dart';
import 'package:collection_app/services/customer_services.dart';
import 'package:flutter/material.dart';

class CustomerClass extends ChangeNotifier {
  CustomerModel? customer;
  bool loading = false;

  getCustomerData() async{
    loading = true;
    customer = (await getRegisteredCustomers())!;
    loading = false;
    notifyListeners();
  }
}