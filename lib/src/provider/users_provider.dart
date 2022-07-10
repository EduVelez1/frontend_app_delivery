import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/src/api/environment.dart';
import 'package:delivery_app/src/models/response_api.dart';
import 'package:delivery_app/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class UsersProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/users';

  late BuildContext context;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<User> getById(String id) async {
    Uri url = Uri.http(_url, '$_api/findById/$id');
    Map<String, String> headers = {'Content-type': 'application/json'};
    final res = await http.get(url, headers: headers);

    final data = json.decode(res.body);
    User user = User.fromJson(data);
    return user;
  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri url = Uri.http(_url, '$_api/create');
    final request = http.MultipartRequest('POST', url);

    if (image != null) {
      request.files.add(http.MultipartFile('image',
          http.ByteStream(image.openRead().cast()), await image.length(),
          filename: basename(image.path)));
    }
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<Stream> update(User user, File? image) async {
    Uri url = Uri.http(_url, '$_api/update');
    final request = http.MultipartRequest('PUT', url);

    if (image != null) {
      request.files.add(http.MultipartFile('image',
          http.ByteStream(image.openRead().cast()), await image.length(),
          filename: basename(image.path)));
    }
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<ResponseApi> create(User user) async {
    Uri url = Uri.http(_url, '$_api/create');
    String bodyParams = json.encode(user);
    Map<String, String> headers = {'Content-type': 'application/json'};
    final res = await http.post(url, headers: headers, body: bodyParams);
    final data = json.decode(res.body);
    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
  }

  Future<ResponseApi> login(String email, String password) async {
    Uri url = Uri.http(_url, '$_api/login');
    String bodyParams = json.encode({'email': email, 'password': password});
    Map<String, String> headers = {'Content-type': 'application/json'};
    final res = await http.post(url, headers: headers, body: bodyParams);
    final data = json.decode(res.body);
    ResponseApi responseApi = ResponseApi.fromJson(data);
    return responseApi;
  }
}
