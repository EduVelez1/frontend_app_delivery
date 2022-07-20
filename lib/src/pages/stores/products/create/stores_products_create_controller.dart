import 'dart:io';
import 'dart:convert';

import 'package:delivery_app/src/models/category.dart';
import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/provider/categories_provider.dart';
import 'package:delivery_app/src/provider/products_provider.dart';
import 'package:delivery_app/src/provider/users_provider.dart';
import 'package:delivery_app/src/utils/my_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:image_picker/image_picker.dart';

class StoresProductsCreateController {
  late BuildContext context;

  late PickedFile pickedFile;
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  TextEditingController nameController = new TextEditingController();
  TextEditingController descripcionController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  CategoryProvider _categoryProvider = new CategoryProvider();
  ProductsProvider _productProvider = new ProductsProvider();

  List<Category> categories = [];
  String idCategory = '';
  late Function refresh;
  ProgressDialog? _progressDialog;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _categoryProvider.init(context);
    _productProvider.init(context);
    getCategories();
    _progressDialog = ProgressDialog(context: context);
  }

  void getCategories() async {
    categories = await _categoryProvider.getAll();
    idCategory = categories[0].id!;
    refresh();
  }

  void createProduct() async {
    String name = nameController.text;
    String descripcion = descripcionController.text;
    String price = priceController.text;

    if (name.isEmpty || descripcion.isEmpty || price.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }
    if (imageFile1 == null || imageFile2 == null || imageFile3 == null) {
      MySnackbar.show(context, 'Selecciona las 3 imagenes');
      return;
    }
    if (idCategory == null) {
      MySnackbar.show(context, 'Selecciona categoria del producto');
      return;
    }

    Product product = new Product(
        name: name,
        description: descripcion,
        price: price,
        idCategory: idCategory);

    List<File> images = [];
    images.add(imageFile1!);
    images.add(imageFile1!);
    images.add(imageFile1!);

    _progressDialog?.show(max: 100, msg: 'Espere un momento');

    Stream stream = await _productProvider.create(product, images);
    stream.listen((res) {
      _progressDialog?.close();
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      MySnackbar.show(context, responseApi.message!);
      if (responseApi.success) {
        resetValues();
      }
    });

    print(product.toJson());
  }

  void resetValues() {
    nameController.text = '';
    descripcionController.text = '';
    priceController.text = '0';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory = categories[0].id!;
    refresh();
  }

  Future selectImage(ImageSource imageSource, int numberFile) async {
    pickedFile =
        await ImagePicker().getImage(source: imageSource) as PickedFile;

    if (pickedFile != null) {
      if (numberFile == 1) {
        imageFile1 = File(pickedFile.path);
      } else if (numberFile == 2) {
        imageFile2 = File(pickedFile.path);
      } else if (numberFile == 3) {
        imageFile3 = File(pickedFile.path);
      }
    }
    Navigator.pop(context);
    refresh();
  }

  void showAlertDialog(int numberFile) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery, numberFile);
        },
        child: Text('GALERIA'));

    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera, numberFile);
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
}
