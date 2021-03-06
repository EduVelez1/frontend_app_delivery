import 'package:delivery_app/src/models/address.dart';
import 'package:delivery_app/src/pages/client/address/list/client_address_list_controller.dart';
import 'package:delivery_app/src/utils/my_colors.dart';
import 'package:delivery_app/src/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientAddressListPage extends StatefulWidget {
  const ClientAddressListPage({Key? key}) : super(key: key);

  @override
  State<ClientAddressListPage> createState() => _ClientAddressListPageState();
}

class _ClientAddressListPageState extends State<ClientAddressListPage> {
  ClientAddressListController _con = new ClientAddressListController();

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
        title: Text('Direcciones'),
        actions: [_iconAdd()],
        backgroundColor: MyColors.primaryColor,
      ),
      body: Stack(
        children: [
          Positioned(top: 0, child: _textSelectAddress()),
          Container(
            margin: EdgeInsets.only(top: 90),
            child: _listAddress(),
          )
        ],
      ),
      bottomNavigationBar: _buttonAccept(),
    );
  }

  Widget noAddress() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          child: NoDataWidget(),
        ),
        _buttonNewAddress()
      ],
    );
  }

  Widget _buttonNewAddress() {
    return Container(
      height: 30,
      child: ElevatedButton(
        onPressed: _con.goToAddressCreate,
        child: Text('Nueva direccion'),
        style: ElevatedButton.styleFrom(primary: Colors.blue),
      ),
    );
  }

  Widget _buttonAccept() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
      child: ElevatedButton(
        onPressed: _con.handleRadioValueChange,
        child: Text('ACEPTAR'),
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            primary: MyColors.primaryColor),
      ),
    );
  }

  Widget _radioSelector(Address address, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: index,
                groupValue: _con.radioValue,
                onChanged: (int? value) {
                  setState(() {
                    _con.radioValue = value!;
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.address ?? '',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    address.detail ?? '',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ],
              )
            ],
          ),
          Divider(
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }

  Widget _listAddress() {
    return FutureBuilder(
      future: _con.findAddress(),
      builder: (context, AsyncSnapshot<List<Address>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data?.length != 0) {
            return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (_, index) {
                  return _radioSelector(snapshot.data![index], index);
                });
          } else {
            return noAddress();
          }
        } else {
          return noAddress();
        }
      },
    );
  }

  Widget _textSelectAddress() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Text(
        'Elige donde recibir tus compras',
        style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _iconAdd() {
    return IconButton(
        onPressed: _con.goToAddressCreate,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ));
  }

  void refresh() {
    setState(() {});
  }
}
