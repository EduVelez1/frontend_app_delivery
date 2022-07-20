import 'package:delivery_app/src/models/address.dart';
import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:delivery_app/src/provider/address_provider.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class ClientAddressListController {
  late BuildContext context;
  late Function refresh;

  List<Address> address = [];
  AddressProvider _addressProvider = new AddressProvider();
  User user = new User(roles: []);
  SharedPref _sharedPref = new SharedPref();
  int radioValue = 0;

  bool isCreated = false;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _addressProvider.init(context);

    // id_user = user.id!;

    refresh();
  }

  Future<List<Address>> findAddress() async {
    user = User.fromJson(await _sharedPref.read('user'));

    return _addressProvider.findByUser(user.id!);
  }

  void goToAddressCreate() async {
    var isCreated = await Navigator.pushNamed(context, 'client/address/create');
    if (isCreated != null) {
      if (isCreated == true) {
        refresh();
      }
    }
  }

  void handleRadioValueChange() {
    print('asd $radioValue');
  }
}
