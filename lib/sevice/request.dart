import 'package:dio/dio.dart';
import 'dart:async';

BaseOptions options = BaseOptions(
  baseUrl: 'http://v.jspang.com:8088/baixing/',
  connectTimeout: 5000,
  receiveTimeout: 3000,
  contentType: 'application/x-www-form-urlencoded'
);
Dio dio = Dio(options);

Future request(url, {formData}) async{
  // print('zheng在请求456789$formData');
  Response res = await dio.post(url, data:formData);
  if(res.statusCode==200) {
    return res.data;
  } else {
    print('接口请求错误$res');
    return res;
  }
}