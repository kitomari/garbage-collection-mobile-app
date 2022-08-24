import 'package:collection_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool>saveUser(User user) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.id);
    prefs.setString('names', user.names);
    prefs.setString('email', user.email);
    prefs.setString('contact', user.contact);
    prefs.setString('username', user.username);
    prefs.setString('roles', user.roles);
    prefs.setString('date', user.date);

    return prefs.commit();
  }


  Future<User> getUser() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id').toString();
    String names = prefs.getString('names').toString();
    String email = prefs.getString('email').toString();
    String contact = prefs.getString('contact').toString();
    String username = prefs.getString('username').toString();
    String roles = prefs.getString('roles').toString();
    String date = prefs.getString('date').toString();

    return User(
      id: id, 
      names: names, 
      email: email, 
      contact: contact, 
      username: username, 
      roles: roles, 
      date: date
    );
  }

  void removeUser() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('names');
    prefs.remove('email');
    prefs.remove('contact');
    prefs.remove('username');
    prefs.remove('roles');
    prefs.remove('date');
  }
}