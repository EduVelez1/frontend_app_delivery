import 'dart:io';

import 'package:delivery_app/src/models/category.dart';
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
      body: ListView(
        children: [
          SizedBox(height: 30),
          _txtNameProduct(),
          _txtDescripcionProduct(),
          _txtPriceProduct(),
          Container(
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _cardImage(_con.imageFile1, 1),
                _cardImage(_con.imageFile2, 2),
                _cardImage(_con.imageFile3, 3)
              ],
            ),
          ),
          _dropDonwCategories(_con.categories),
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _cardImage(File? imagenFile, int numberFile) {
    return GestureDetector(
      onTap: () {
        _con.showAlertDialog(numberFile);
      },
      child: Card(
        elevation: 3.0,
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width * 0.26,
          child: imagenFile != null
              ? Image.file(imagenFile, fit: BoxFit.cover)
              : Image(image: AssetImage('assets/img/add_image.png')),
        ),
      ),
    );
  }

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
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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

  Widget _dropDonwCategories(List<Category> categories) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 33),
      child: Material(
        color: Colors.white,
        elevation: 2.0,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.search,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(width: 15),
                  Text(
                    'Categorias',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  underline: Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.arrow_drop_down_circle,
                      color: MyColors.primaryColor,
                    ),
                  ),
                  elevation: 3,
                  isExpanded: true,
                  hint: Text(
                    'Seleccionar categorias',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  items: _dropDownItems(categories),
                  onChanged: (String? option) {
                    _con.idCategory = option!;
                    print(_con.idCategory);
                  },
                  value: _con.idCategory,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) => {
          list.add(
              DropdownMenuItem(child: Text(category.name!), value: category.id))
        });
    return list;
  }

  void refresh() {
    setState(() {});
  }
}
