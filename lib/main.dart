import 'package:delivery_app/src/pages/client/products/list/client_products_list_page.dart';
import 'package:delivery_app/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:delivery_app/src/pages/login/login_page.dart';
import 'package:delivery_app/src/pages/register/register_page.dart';
import 'package:delivery_app/src/pages/roles/roles_page.dart';
import 'package:delivery_app/src/pages/stores/orders/list/stores_orders_list_page.dart';
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
          primaryColor: MyColors.primaryColor
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => const LoginPage(),
          'register': (BuildContext context) => const RegisterPage(),
          'roles': (BuildContext context) => const RolesPage(),
          'client/products/list': (BuildContext context) => const ClientProductsListPage(),
          'stores/orders/list': (BuildContext context) => const StoresOrdersListPage(),
          'delivery/orders/list': (BuildContext context) => const DeliveryOrdersListPage()

        },
       
        );
  }
}
