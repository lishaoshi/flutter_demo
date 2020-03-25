import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './handleRouters.dart';
class Routers {
  static String root = "/";
  static String goodsDetail = "/goods_detail";

  static void configureRoutes (Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(goodsDetail, handler: goodsDetailHandle);
  }
}

