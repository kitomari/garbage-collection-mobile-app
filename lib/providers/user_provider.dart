import 'package:collection_app/models/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier{
  User _user = User(
    id: '', 
    names: '', 
    email: '', 
    contact: '', 
    username: '', 
    roles: '', 
    date: '', 
    // status: '',
  );
  User get user => _user;
  void setUser(String user){
    _user = User.fromJson(user);
    notifyListeners();
  }
}