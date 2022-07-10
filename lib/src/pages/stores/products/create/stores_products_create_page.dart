import 'dart:html';

import 'package:delivery_app/src/pages/stores/products/create/stores_products_create_controller.dart';
import 'package:delivery_app/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class StoresProductsCreatePage extends StatefulWidget {
  const StoresProductsCreatePage({Key? key}) : super(key: key);

  @override
  State<StoresProductsCreatePage> createState() =>
      _StoresProductsCreatePageState();
}

class _StoresProductsCreatePageState extends State<StoresProductsCreatePage> {
  StoresProductsCreateController _con = new StoresProductsCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo producto'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          _txtNameProduct(),
          _txtDescripcionProduct(),
          _txtPriceProduct()
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  // Widget _cardImage(File imagenFile, int numberFile) {
  //   return Card(
  //     elevation: 3.0,
  //     child: Container(
  //         height: 140,
  //         width: MediaQuery.of(context).size.width * 0.26,
  //         child: Image( imagen: imagenFile ??)),
  //   );
  // }

  Widget _buttonCreate() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.createProduct,
        child: Text('CREAR PRODUCTO'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _txtNameProduct() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        maxLength: 50,
        // obscureText: true,
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre del producto',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(Icons.description, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _txtDescripcionProduct() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        maxLength: 250,
        maxLines: 3,
        // obscureText: true,
        controller: _con.descripcionController,
        decoration: InputDecoration(
          hintText: 'Descripcion del producto',
          hintStyle: TextStyle(
            color: MyColors.primaryColorDark,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(15),
          // suffixIcon: Icon(Icons.list_alt, color: MyColors.primaryColor)
        ),
      ),
    );
  }

  Widget _txtPriceProduct() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        // obscureText: true,
        controller: _con.priceController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Precio del producto',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon:
                Icon(Icons.monetization_on, color: MyColors.primaryColor)),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
