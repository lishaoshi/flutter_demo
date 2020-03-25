import 'package:flutter/cupertino.dart';

import './request.dart';

//获取分类列表数据
Future getClassData({formData}) {
  return request('wxmini/getCategory');
}

//获取商品列表
Future getClassGoodsList(url, formData) {
  return request(url, formData:formData);
}