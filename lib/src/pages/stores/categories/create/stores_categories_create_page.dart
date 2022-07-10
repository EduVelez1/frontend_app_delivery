import 'package:delivery_app/src/pages/stores/categories/create/stores_categories_create_controller.dart';
import 'package:delivery_app/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class StoresCategoriesCreatePage extends StatefulWidget {
  const StoresCategoriesCreatePage({Key? key}) : super(key: key);

  @override
  State<StoresCategoriesCreatePage> createState() =>
      _StoresCategoriesCreatePageState();
}

class _StoresCategoriesCreatePageState
    extends State<StoresCategoriesCreatePage> {
  StoresCategoriesCreateController _con =
      new StoresCategoriesCreateController();

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
        title: Text('Nueva categoria'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          _txtNameCategoria(),
          _txtDescripcionCategoria()
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _buttonCreate() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.createCategory,
        child: Text('CREAR CATEGORIA'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _txtNameCategoria() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        // obscureText: true,
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre de la categoria',
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            suffixIcon: Icon(Icons.description, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _txtDescripcionCategoria() {
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
          hintText: 'Descripcion de la categoria',
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

  void refresh() {
    setState(() {});
  }
}
