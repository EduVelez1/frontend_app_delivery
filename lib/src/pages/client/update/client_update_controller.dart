import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/provider/users_provider.dart';
import 'package:delivery_app/src/utils/my_snackbar.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientUpdateController {
  late BuildContext context;

  TextEditingController nameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  late PickedFile pickedFile;
  File? imageFile;
  late Function refresh;
  ProgressDialog? _progressDialog;
  bool isEnable = true;

  SharedPref _sharedPref = new SharedPref();
  User user = new User(roles: []);

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    await usersProvider.init(context);

    nameController.text = user.name!;
    lastnameController.text = user.lastname!;
    phoneController.text = user.phone!;

    refresh();
  }

  void update() async {
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text.trim();

    if (name.isEmpty || lastname.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    // if (imageFile == null) {
    //   MySnackbar.show(context, 'Seleccione una imagen');
    //   return;
    // }

    _progressDialog?.show(max: 100, msg: 'Cargando imagen');

    isEnable = false;

    User userActualizado = new User(
        id: user.id,
        name: name,
        lastname: lastname,
        phone: phone,
        image: user.image,
        //password: password,
        roles: []);

    Stream stream =
        await usersProvider.update(userActualizado, imageFile ?? null);
    stream.listen((res) async {
      _progressDialog?.close();
      // ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      // print(responseApi.toJson());

      // MySnackbar.show(context, responseApi.message.toString());
      Fluttertoast.showToast(msg: responseApi.message.toString());

      if (responseApi.success) {
        user = await usersProvider.getById(userActualizado.id!);
        _sharedPref.save('user', user.toJson());

        Navigator.pushReplacementNamed(context, 'client/products/list');
      } else {
        isEnable = true;
      }
    });
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile =
        await ImagePicker().getImage(source: imageSource) as PickedFile;

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('GALERIA'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('CAMARA'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void back() {
    Navigator.pop(context);
  }
}
