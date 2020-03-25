import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter_app/model/cartModel.dart';


class CartProvide extends ChangeNotifier {
  String cartString = "";
  List<CartModel> cartList = [];
  int cartGoodsAllLength = 0; //购物车总的数量
  //购物车总价格
  double price = 0;
  //是否默认全选
  bool isAllCheckt = true;
  //添加到购物车
  addCartShop(Map<String, dynamic> item) async{
    
    //item代表添加地某个商品的信息
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString==null?[]:json.decode(cartString.toString());
    // print('$item-------$cartString-----$temp');
    List<Map> tempList = (temp as List).cast();
    bool isHave = false; //本次添加商品是否已经存在购物车数据中  false：默认没有
    int index = 0;
    tempList.forEach((items){
      if(items['goodsId']==item['goodsId']) {
        isHave = true; //id一样，表示购物车存在
        items['count']++;
      }
      index++;
    });
    if(!isHave) {
      tempList.add(item);
    }
    cartString = json.encode(tempList).toString();
    print(cartString);
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }


  //马上购买---当前先做清空购物车
  buyGoods({Map<String, dynamic> item}) async{
    SharedPreferences pres = await SharedPreferences.getInstance();
    pres.clear();
  }


  //读取购物车的数据
  getCartInfo() async {
    cartGoodsAllLength = 0;
    price = 0;
    SharedPreferences pres = await SharedPreferences.getInstance();
    cartList = [];
    cartString = pres.getString('cartInfo');
    // print('读取购物车');
    if(cartString == null) {
      cartList = [];
    } else {
      List<Map> cartItemArr = (json.decode(cartString.toString()) as List).cast();
      cartItemArr.forEach((item){
        if(item['isCheck']) {
         cartGoodsAllLength++;
          price +=item['price'];
        }
         cartList.add(CartModel.formJson(item));
      
      });
    }
    print('getCartInfo$cartList');
    notifyListeners();
  }


  //删除按钮
  deleteGoods(String id) async{
    cartGoodsAllLength = 0;
    // price = 0;
    //根据id删除购物车
    SharedPreferences pres = await SharedPreferences.getInstance();
    cartString = pres.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int index = 0;
    int deletIndex = 0;
    cartList = [];
    
    tempList.forEach((item){
      if(item['goodsId'] == id) {
        deletIndex = index;
        price -=item['price'];
      } else {
        cartList.add(CartModel.formJson(item));
        cartGoodsAllLength++;
      }
      index++;
    });
    tempList.removeAt(deletIndex);
    cartString = json.encode(tempList).toString();
    pres.setString('cartInfo', cartString);
    notifyListeners();
  }


  //点击某个购物车的单选框
  changGoodsCheckt(String id) async{
    cartList = [];
    SharedPreferences pres = await SharedPreferences.getInstance();
    cartString = pres.getString('cartInfo');
    List<Map> tempList = cartString == null? []:(json.decode(cartString.toString()) as List).cast();
    isAllCheckt = true;
    tempList.forEach((item){
      if(item['goodsId'] == id) {
        item['isCheck'] = !item['isCheck'];
      }
      if(!item['isCheck']) {
        isAllCheckt = false;
      }
      // cartList.add(CartModel.formJson(item));
    });
    cartString = json.encode(tempList);
    pres.setString('cartInfo', cartString);
    await getCartInfo();

  }

  //全选按钮切换
  allCheckChange(BuildContext context, bool flag) async{
    cartList = [];
    SharedPreferences pres = await SharedPreferences.getInstance();
    cartString = pres.getString('cartInfo');
    List<Map> tempList = cartString == null? []:(json.decode(cartString.toString()) as List).cast();
    tempList.forEach((item){
      item['isCheck'] = flag;
      // cartList.add(CartModel.formJson(item));
    });
    cartString = json.encode(tempList);
    pres.setString('cartInfo', cartString);
    isAllCheckt = !isAllCheckt;
    await getCartInfo();
  }
}