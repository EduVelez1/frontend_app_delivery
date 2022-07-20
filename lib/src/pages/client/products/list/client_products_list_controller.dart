import 'package:delivery_app/src/models/category.dart';
import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:delivery_app/src/provider/categories_provider.dart';
import 'package:delivery_app/src/provider/products_provider.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClienteProductsListController {
  late BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  late Function refresh;
  User user = new User(roles: []);

  List<Category> categories = [];
  CategoryProvider _categoryProvider = new CategoryProvider();
  ProductsProvider _productsProvider = new ProductsProvider();

  Future init(BuildContext context, refresh) async {
    this.context = context;
    this.refresh = refresh;

    user = User.fromJson(await _sharedPref.read('user'));
    _categoryProvider.init(context);
    _productsProvider.init(context);

    getCategories();
    refresh();
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return _productsProvider.getByCategory(idCategory);
  }

  void getCategories() async {
    categories = await _categoryProvider.getAll();
    refresh();
  }

  void openBottomSheet(Product product) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => ClientProductsDetailPage(product: product),
    );
  }

  void logout() {
    _sharedPref.logout(context);
  }

  void openDrawer() {
    key.currentState?.openDrawer();
  }

  void goToUpdatePage() {
    Navigator.pushNamed(context, 'client/update');
  }

  void goToRoles() {
    Navigator.pushReplacementNamed(context, 'roles');
  }

  void goToOrdersCreatePage() {
    Navigator.pushNamed(context, 'client/orders/create');
  }
}
