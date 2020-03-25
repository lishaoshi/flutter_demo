import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/components/checkt.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/cartProvide.dart';


class CartItem extends StatelessWidget {
  final item;
  const CartItem({Key key, this.item}) : super(key: key);

  void onChangeCheckt (BuildContext context, val) {
    // item.isCheck = val;
    print('点击了单选框${item}');
    // debugger();
    Provide.value<CartProvide>(context).changGoodsCheckt(item.goodsId);
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5.0, 4.0, 5.0),
      height: ScreenUtil().setHeight(160),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12
          )
        )
      ),
      child: Row(
        children: <Widget>[
          CheckW(flag: item.isCheck, callbacks: onChangeCheckt,),
          goodsImg(item.images),
          goodsName(item.goodsName),
          goodsPrice(context, item.price, item.goodsId)
        ],
      )
    );
  }


//商品图片
  Widget goodsImg(String url) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,

        )
      ),
      width: ScreenUtil().setWidth(150),
      height: ScreenUtil().setHeight(150),
        child: Image.network(url,
        fit: BoxFit.fill,
      ),
    );
  }

  //商品名称
  Widget goodsName( String name) {
    return Container(
      alignment: Alignment.topLeft,
       width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      // height: ScreenUtil().setHeight(120),
      // color: Colors.red,
      child: Column(
        children: <Widget>[
           Text('$name'),
        ]
      )
    );
  }

  //商品价格
  Widget goodsPrice(BuildContext context, double price, String id) {
    return Container(
      // alignment: Alignment.topRight,
      width:ScreenUtil().setWidth(150) ,
        alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text('￥$price'),
          deleteGoodsButton(context, id)
        ]
      ),
    );
  }
}

//删除按钮
Widget deleteGoodsButton(BuildContext context, String id) {
  return Container(
    child: InkWell(
      onTap: () {
        // print(id);
        Provide.value<CartProvide>(context).deleteGoods(id);
      },
      child: Icon(Icons.restore_from_trash,size: 35,),
    ),
  );
}