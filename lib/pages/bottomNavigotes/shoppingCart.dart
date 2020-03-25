import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/cartProvide.dart';
import 'package:flutter_app/model/cartModel.dart';
import 'package:flutter_app/pages/components/cartCom/cartItem.dart';
import 'package:flutter_app/pages/components/cartCom/cartBottom.dart';


class CartPage extends StatelessWidget {
  const CartPage({Key key}) : super(key: key);

  //获取购物车数据
  Future<String> getCartList (BuildContext context) async{
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车')
      ),
      body: FutureBuilder(
        future: getCartList(context),
        builder: (context, snapShot){
          if(snapShot.hasData) {
            return Provide<CartProvide>(
              builder: (context, child, val) {
              List<CartModel> cartList = Provide.value<CartProvide>(context).cartList;
              final double price = val.price;
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(102)),
                      child:  ListView.builder(
                        itemCount: cartList.length+1,
                        itemBuilder: (context, index) {
                          // print('${index}-- ${val.cartGoodsAllLength}');
                          if(index == cartList.length) {
                            return Container(
                              height: ScreenUtil().setHeight(60),
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('共${val.cartGoodsAllLength}件商品'),
                                  Text('小计：￥$price',style: TextStyle(color: Colors.redAccent),)
                                ]
                              ),
                            );
                          }
                          return CartItem(item: cartList[index]);
                      })
                    ),
                    Positioned(
                      child: CartBottomW(price: price, cartLength: val.cartGoodsAllLength),
                      left: 0,
                      bottom: 0,
                      right: 0
                    )
                  ],
                );
              });
            
          } else {
            return Text('123');
          }
        }
      ),
    );
  }
}