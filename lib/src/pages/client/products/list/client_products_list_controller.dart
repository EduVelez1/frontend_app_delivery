import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClienteProductsListController {
 late BuildContext context;
 SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async {
    this.context = context;

  }

  logout(){
    _sharedPref.logout(context);
  }

}