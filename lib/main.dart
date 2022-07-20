import 'package:delivery_app/src/pages/client/address/create/client_address_create_controller.dart';
import 'package:delivery_app/src/pages/client/address/create/client_address_create_page.dart';
import 'package:delivery_app/src/pages/client/address/list/client_address_list_page.dart';
import 'package:delivery_app/src/pages/client/address/map/client_address_map_page.dart';
import 'package:delivery_app/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:delivery_app/src/pages/client/products/list/client_products_list_page.dart';
import 'package:delivery_app/src/pages/client/update/client_update_page.dart';
import 'package:delivery_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_app/src/pages/login/login_page.dart';
import 'package:delivery_app/src/pages/register/register_page.dart';
import 'package:delivery_app/src/pages/roles/roles_page.dart';
import 'package:delivery_app/src/pages/stores/categories/create/stores_categories_create_page.dart';
import 'package:delivery_app/src/pages/stores/orders/list/stores_orders_list_page.dart';
import 'package:delivery_app/src/pages/stores/products/create/stores_products_create_page.dart';
import 'package:delivery_app/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      theme: ThemeData(
          primaryColor: MyColors.primaryColor,
          appBarTheme: AppBarTheme(elevation: 0)),
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => const LoginPage(),
        'register': (BuildContext context) => const RegisterPage(),
        'roles': (BuildContext context) => const RolesPage(),
        'client/products/list': (BuildContext context) =>
            const ClientProductsListPage(),
        'client/update': (BuildContext context) => const ClientUpdatePage(),
        'client/orders/create': (BuildContext context) =>
            const ClientOrdersCreatePage(),
        'client/address/create': (BuildContext context) =>
            const ClientAddressCreatePage(),
        'client/address/list': (BuildContext context) =>
            const ClientAddressListPage(),
        'client/address/map': (BuildContext context) =>
            const ClientAddressMapPage(),
        'stores/orders/list': (BuildContext context) =>
            const StoresOrdersListPage(),
        'stores/categories/create': (BuildContext context) =>
            const StoresCategoriesCreatePage(),
        'stores/products/create': (BuildContext context) =>
            const StoresProductsCreatePage(),
        'delivery/orders/list': (BuildContext context) =>
            const DeliveryOrdersListPage(),
      },
    );
  }
}
