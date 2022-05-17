import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class RolesController {
  

  BuildContext? context;
  Function? refresh;
  User user = new User(roles: []);
  SharedPref sharedPref = new SharedPref();

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;


  user = User.fromJson(await sharedPref.read('user'));
  refresh();


  }

  void goToPage(String route){
    Navigator.pushReplacementNamed(context!, route);
  }

 
}