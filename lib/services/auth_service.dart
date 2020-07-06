import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Dio dio = new Dio();

  login(String name, String password) async {
    try {
      return await dio.post(
        'https://fluttermongodb.herokuapp.com/authenticate',
        data: {'name': name, 'password': password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );
    } on DioError catch (e) {
      print(e.response.data);
      FlutterToast.showToast(
        msg: e.response.data['msg'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  addUser(name, password) async {
    return await dio.post(
      'https://fluttermongodb.herokuapp.com/adduser',
      data: {'name': name, 'password': password},
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );
  }

  getInfo(token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    return await dio.get('https://fluttermongodb.herokuapp.com/getinfo');
  }
}
