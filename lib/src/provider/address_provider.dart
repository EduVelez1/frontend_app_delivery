import 'dart:convert';

import 'package:delivery_app/src/api/environment.dart';
import 'package:delivery_app/src/models/address.dart';
import 'package:delivery_app/src/models/category.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddressProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/address';

  late BuildContext context;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<ResponseApi> create(Address address) async {
    Uri url = Uri.http(_url, '$_api/create');
    String bodyParams = json.encode(address);
    Map<String, String> headers = {'Content-type': 'application/json'};
    final res = await http.post(url, headers: headers, body: bodyParams);
    final data = json.decode(res.body);
    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
  }

  Future<List<Address>> findByUser(String idUser) async {
    Uri url = Uri.http(_url, '$_api/findByUser/$idUser');
    Map<String, String> headers = {'Content-type': 'application/json'};
    final res = await http.get(url, headers: headers);

    final data = json.decode(res.body);
    Address address = Address.fromJsonList(data);
    return address.toList;
  }
}
