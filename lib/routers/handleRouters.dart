import 'dart:developer';

import 'package:fluro/fluro.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../pages/goodsDetail/detail_page.dart';

//根路由handle
// var rootRouterHandle = Handler(
//   // handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   //   return  
//   // }
// );
var goodsDetailHandle = Handler(
  handlerFunc:(BuildContext context, Map<String, List<String>> params) {
    String goodsId = params['id'].first;
    return DetailPage(goodsId:goodsId);
  }
);