import 'dart:convert';

import 'package:delivery_app/src/api/environment.dart';
import 'package:delivery_app/src/models/category.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/categories';

  late BuildContext context;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<ResponseApi> create(Category category) async {
    Uri url = Uri.http(_url, '$_api/create');
    String bodyParams = json.encode(category);
    Map<String, String> headers = {'Content-type': 'application/json'};
    final res = await http.post(url, headers: headers, body: bodyParams);
    final data = json.decode(res.body);
    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
  }

  Future<List<Category>> getAll() async {
    Uri url = Uri.http(_url, '$_api/getAll');
    Map<String, String> headers = {'Content-type': 'application/json'};
    final res = await http.get(url, headers: headers);

    final data = json.decode(res.body);
    Category category = Category.fromJsonList(data);
    return category.toList;
  }
}
