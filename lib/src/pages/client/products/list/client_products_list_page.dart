import 'package:delivery_app/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({ Key? key }) : super(key: key);

  @override
  State<ClientProductsListPage> createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {

  ClienteProductsListController _con = new ClienteProductsListController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.init(context);
     });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
      child: ElevatedButton(
        child: Text('Cerrar sesion'),
        onPressed: _con.logout,
        ),
      ),      
    );
  }
}