import 'dart:async';

import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapController {
  late BuildContext context;
  late Function refresh;
  CameraPosition initialPosition =
      CameraPosition(target: LatLng(-0.965615, -80.7113029), zoom: 14);

  Completer<GoogleMapController> _mapController = Completer();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    refresh();
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  void goToAddressCreate() {
    Navigator.pushNamed(context, 'client/address/create');
  }
}
