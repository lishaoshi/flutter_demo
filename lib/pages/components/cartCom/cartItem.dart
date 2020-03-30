
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
          goodsName(context, item.goodsName),
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
  Widget goodsName(BuildContext context, String name) {
    return Container(
      // color: Colors.red,
      alignment: Alignment.topLeft,
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      // height: ScreenUtil().setHeight(120),
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
           Text('$name'),
           goodsNumColltr(context)
        ]
      )
    );
  }

  //商品数量控制器
  Widget goodsNumColltr(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color:Colors.black26),
        // color: Colors.red,
      ),
      height: ScreenUtil().setHeight(35),
      // alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          InkWell(
            onTap: () async{
              await Provide.value<CartProvide>(context).deleteGoodsItem(item.goodsId);
              // await Provide.value<CartProvide>(context).addCartShop(item.toJson());
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(item.count>1?'-':' '),
              width: ScreenUtil().setWidth(40),
              decoration: BoxDecoration(
                color: item.count > 1?Colors.white:Colors.black12,
                border: Border(
                  right: BorderSide(color: Colors.black12)
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text('${item.count}'),
          color: Colors.white,
            width: ScreenUtil().setWidth(70),
          ),
          InkWell(
            onTap: () async{
              // print('123123${item.toJson()}');
              await Provide.value<CartProvide>(context).addCartShop(item.toJson());
              await Provide.value<CartProvide>(context).getCartInfo();
            },
            child:  Container(
            alignment: Alignment.center,
            child: Text('+'),
            width: ScreenUtil().setWidth(40),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(color: Colors.black12)
              ),
            ),
          ),
          ),
         
        ]
      ),
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