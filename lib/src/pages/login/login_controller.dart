import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/provider/users_provider.dart';
import 'package:delivery_app/src/utils/my_snackbar.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class LoginController {
  late BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref();
  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);

    User user = User.fromJson(await _sharedPref.read('user') ?? {});

    if (user.sessionToken != null) {
      if (user.roles.length > 1) {
        Navigator.pushReplacementNamed(context, 'roles');
                // Navigator.pushReplacementNamed(context, 'client/products/list');

      } else {
        Navigator.pushReplacementNamed(context, user.roles[0].route.toString());
      }
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void goToHomePage() {
    // Navigator.pushNamed(context!, 'roles');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);
    if (responseApi.success) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());

      print('USUARIO LOGUEADO: ${user.toJson()}');

      if (user.roles.length > 1) {
        Navigator.pushReplacementNamed(context, 'roles');
        // Navigator.pushReplacementNamed(context, 'client/products/list');

      } else {
        Navigator.pushReplacementNamed(context, user.roles[0].route.toString());
      }
    } else {
      MySnackbar.show(context, responseApi.message.toString());
    }
    // print(responseApi.toJson());
  }
}
