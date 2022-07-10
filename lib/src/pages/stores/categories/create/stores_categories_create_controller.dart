import 'package:delivery_app/src/provider/users_provider.dart';
import 'package:delivery_app/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class StoresCategoriesCreateController {
  late BuildContext context;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descripcionController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  late Function refresh;
  // ProgressDialog? _progressDialog;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    // _progressDialog = ProgressDialog(context: context);
  }

  void createCategory() {
    String name = nameController.text;
    String descripcion = descripcionController.text;

    if (name.isEmpty || descripcion.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }
  }
}
