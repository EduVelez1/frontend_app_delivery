import 'package:delivery_app/src/models/address.dart';
import 'package:delivery_app/src/pages/client/address/create/client_address_create_controller.dart';
import 'package:delivery_app/src/utils/my_colors.dart';
import 'package:delivery_app/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientAddressCreatePage extends StatefulWidget {
  const ClientAddressCreatePage({Key? key}) : super(key: key);

  @override
  State<ClientAddressCreatePage> createState() =>
      _ClientAddressCreatePageState();
}

class _ClientAddressCreatePageState extends State<ClientAddressCreatePage> {
  ClientAddressCreateController _con = new ClientAddressCreateController();

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
        title: Text('Nueva direccion'),
        backgroundColor: MyColors.primaryColor,
      ),
      bottomNavigationBar: _buttonAccept(),
      body: Column(
        children: [
          _textCompleteData(),
          _textFieldAddress(),
          _textFieldNeigh(),
          // _textFieldReferencia()
        ],
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
        onPressed: _con.createAddress,
        child: Text('CREAR DIRECCION'),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            primary: MyColors.primaryColor),
      ),
    );
  }

  Widget _textFieldReferencia() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        onTap: _con.openMap,
        autofocus: false,
        focusNode: AlwaysDisabledFocusNode(),
        decoration: InputDecoration(
            labelText: 'Punto de referencia',
            suffixIcon: Icon(
              Icons.map,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.addressController,
        decoration: InputDecoration(
            labelText: 'Direccion',
            suffixIcon: Icon(
              Icons.location_on,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldNeigh() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: _con.detailsController,
        maxLines: 3,
        maxLength: 255,
        decoration: InputDecoration(
            labelText: 'Detalle direccion',
            suffixIcon: Icon(
              Icons.location_city,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textCompleteData() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Text(
        'Completa estos datos',
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
