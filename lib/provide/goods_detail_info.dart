import 'dart:developer';

import 'package:flutter/material.dart';
import '../pages/goodsDetail/detailModel.dart';
import '../sevice/goods_detail.dart';
import 'dart:convert';


class DetailPagePrvide with ChangeNotifier {
  DetailPageModel goodsDetailInfo;

  //详情与评论区的状态
  bool leftRightFlag = false;

  //获取商品详情函数
  getGoodsDetailFnc(String id) async{
    var params = {'goodId': id};
    goodsDetailInfo = DetailPageModel();
    await homeDataContent(formData:params).then((val){
      var responseData= json.decode(val.toString());
      goodsDetailInfo = DetailPageModel.fromJson(responseData);
      notifyListeners();
    });
  }
  //评论区与详情
  changeFlag(String flag) {
    flag=="left"?leftRightFlag=false:leftRightFlag=true;
    notifyListeners();
  }
}
