import 'package:delivery_app/src/models/address.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/pages/client/address/map/client_address_map_page.dart';
import 'package:delivery_app/src/provider/address_provider.dart';
import 'package:delivery_app/src/utils/my_snackbar.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientAddressCreateController {
  late BuildContext context;
  late Function refresh;
  User user = new User(roles: []);
  SharedPref _sharedPref = new SharedPref();

  TextEditingController addressController = new TextEditingController();
  TextEditingController detailsController = new TextEditingController();

  AddressProvider _addressProvider = new AddressProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));

    _addressProvider.init(context);

    refresh();
  }

  void createAddress() async {
    String address = addressController.text;
    String detail = detailsController.text;

    if (address.isEmpty || detail.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos');
      return;
    }

    Address myAddress =
        new Address(address: address, id_user: user.id, detail: detail);
    ResponseApi responseApi = await _addressProvider.create(myAddress);
    if (responseApi.success) {
      Fluttertoast.showToast(msg: responseApi.message.toString());
      Navigator.pop(context, true);
    }
  }

  void openMap() {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => ClientAddressMapPage(),
    );
  }
}
