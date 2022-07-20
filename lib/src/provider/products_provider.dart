import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:delivery_app/src/api/environment.dart';
import 'package:delivery_app/src/models/category.dart';
import 'package:delivery_app/src/models/product.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/products';

  late BuildContext context;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<List<Product>> getByCategory(String idCategory) async {
    Uri url = Uri.http(_url, '$_api/findByCategory/$idCategory');
    Map<String, String> headers = {'Content-type': 'application/json'};
    final res = await http.get(url, headers: headers);

    final data = json.decode(res.body);
    Product product = Product.fromJsonList(data);
    return product.toList;
  }

  Future<Stream> create(Product product, List<File> images) async {
    Uri url = Uri.http(_url, '$_api/create');
    final request = http.MultipartRequest('POST', url);

    for (int i = 0; i < images.length; i++) {
      request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(images[i].openRead().cast()),
          await images[i].length(),
          filename: basename(images[i].path)));
    }
    request.fields['product'] = json.encode(product);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }
}
