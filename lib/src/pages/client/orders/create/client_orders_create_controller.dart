import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientOrdersCreateController {
  late BuildContext context;
  late Function refresh;
  int counter = 1;
  double productPrice = 0.0;

  SharedPref _sharedPref = new SharedPref();

  List<Product> selectedProducts = [];
  double total = 0;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    var order = await _sharedPref.read('order');
    if (order != null) {
      selectedProducts =
          Product.fromJsonList(await _sharedPref.read('order')).toList;
    }

    getTotal();
    refresh();
  }

  void getTotal() {
    total = 0;
    selectedProducts.forEach((element) {
      total = total +
          (double.parse(element.quantity!) * double.parse(element.price!));
    });
    refresh();
  }

  void addItem(Product product) {
    int index =
        selectedProducts.indexWhere((element) => element.id == product.id);
    String cantidadActual = selectedProducts[index].quantity!;
    int total = int.parse(cantidadActual) + 1;
    selectedProducts[index].quantity = total.toString();
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void removeItem(Product product) {
    if (int.parse(product.quantity!) > 1) {
      int index =
          selectedProducts.indexWhere((element) => element.id == product.id);
      String cantidadActual = selectedProducts[index].quantity!;
      int total = int.parse(cantidadActual) - 1;
      selectedProducts[index].quantity = total.toString();
      _sharedPref.save('order', selectedProducts);
      getTotal();
    }
  }

  void deleteItem(Product product) {
    selectedProducts.removeWhere((element) => element.id == product.id);
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void goToAddress() {
    Navigator.pushNamed(context, 'client/address/list');
  }
}
