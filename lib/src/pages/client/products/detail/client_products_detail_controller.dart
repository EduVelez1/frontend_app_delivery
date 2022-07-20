import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientProductsDetailController {
  late BuildContext context;
  late Function refresh;
  Product product = new Product();
  int counter = 1;
  double productPrice = 0.0;

  SharedPref _sharedPref = new SharedPref();

  List<Product> selectedProducts = [];

  Future init(BuildContext context, Function refresh, Product product) async {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    // _sharedPref.remove('order');
    productPrice = double.parse(product.price!);
    product.quantity = counter.toString();
    var order = await _sharedPref.read('order');
    if (order != null) {
      selectedProducts =
          Product.fromJsonList(await _sharedPref.read('order')).toList;
    }

    refresh();
  }

  void addToBag() {
    int index =
        selectedProducts.indexWhere((element) => element.id == product.id);
    if (index == -1) {
      if (product.quantity == null) {
        product.quantity = '1';
      }
      selectedProducts.add(product);
    } else {
      selectedProducts[index].quantity = counter.toString();
    }

    _sharedPref.save('order', selectedProducts);
    Fluttertoast.showToast(msg: 'Productos agregado');
  }

  void addItem() {
    counter++;
    productPrice = double.parse(product.price!) * counter;
    product.quantity = counter.toString();
    refresh();
  }

  void removeItem() {
    if (counter > 1) {
      counter--;
      productPrice = double.parse(product.price!) * counter;
      product.quantity = counter.toString();
      refresh();
    }
  }

  void close() {
    Navigator.pop(context);
  }
}
