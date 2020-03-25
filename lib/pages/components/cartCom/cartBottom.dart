import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../checkt.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/cartProvide.dart';

class CartBottomW extends StatelessWidget {
  //购物车总价格
  final double price;
  final int cartLength;
  // final GestureTapCallback onChangeCallvack;
  // final 
  CartBottomW({Key key, this.price, this.cartLength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Function changeAllCheck = Provide.value<CartProvide>(context).allCheckChange;
    return Provide<CartProvide>(builder: (context, child, val){
      return Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.black12
            )
          )
        ),
        // color: Colors.red,
        child: Row(children: <Widget>[
          CheckW(flag: val.isAllCheckt, callbacks: changeAllCheck),
          Text('全选'),
          Expanded(
            flex: 1,
            child: Container(
              // color: Colors.blue,
              alignment: Alignment.topRight,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end, 
                children: <Widget>[
            Text.rich(TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: '合计：', style: TextStyle(fontSize: ScreenUtil().setSp(28))),
                TextSpan(
                    text: '￥${price}', style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Colors.redAccent)),
              ])),
            Text('满68元免配送费，预购免配送费')
          ]))),
          Container(
            alignment: Alignment.center,
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                height: ScreenUtil().setHeight(60),
                margin: EdgeInsets.only(left: 10),
                width: ScreenUtil().setWidth(120),
                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                // padding: ,
                child: Text('结算(${cartLength})',style: TextStyle(color: Colors.white,)),
                
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.red,
                ),
              )
            ),
          )
        ]),
      ); 
    });
  }
}
