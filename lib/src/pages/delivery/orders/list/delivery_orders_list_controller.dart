import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class DeliveryListController {
  late BuildContext context;
  User user = new User(roles: []);

  Function ?refresh;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Future init(BuildContext context, refresh) async {
    this.context = context;
    user = User.fromJson(await _sharedPref.read('user'));

    refresh();
  }

  void logout() {
    _sharedPref.logout(context);
  }

 void openDrawer() {
    key.currentState?.openDrawer();
  }

    void goToRoles() {
    Navigator.pushReplacementNamed(context, 'roles');
  }
}
