import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/provide/cartProvide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/goods_detail_info.dart';
import 'package:flutter_app/provide/homeProvide.dart';



class DetailBottom extends StatelessWidget {
  const DetailBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<HomeProvide>(builder: (context, child, val){
      return  Container(
        height: ScreenUtil().setHeight(80.0),
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  val.changeBottomIndex(2);
                  Navigator.pop(context);
                },
                hoverColor: Colors.red,
                splashColor: Colors.red,
                highlightColor: Colors.red,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_cart,
                        size: 35,
                        color: Colors.red,
                      ),
                      Positioned(
                        right: -5,
                        top: -5,
                        child: Provide<CartProvide>(builder: (context, child, val){
                          
                          return Container(
                            child: Text('${val.cartGoodsAllLength}', style: TextStyle(color: Colors.white,),),
                            padding: EdgeInsets.fromLTRB(6,3,6,3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Colors.red,
                              border: Border.all(width: 2, color: Colors.white)
                            ),
                          );
                        }),
                      ) 
                    ],
                  )
                ) ,
              ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
              onTap: (){
                
                var goodsInfo = Provide.value<DetailPagePrvide>(context).goodsDetailInfo.data.goodInfo;
                Map<String, dynamic> item = {
                  'goodsId': goodsInfo.goodsId,
                  'goodsName': goodsInfo.goodsName,
                  'count': 1,
                  'price': goodsInfo.presentPrice,
                  'images': goodsInfo.image1,
                  'isCheck': true
                };
                Provide.value<CartProvide>(context).addCartShop(item);
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.green,
                child: Text(
                  '加入购物车',
                  style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
                ),
              ) ,
            ),
            ),
            Expanded(
              flex: 2,
              child: InkWell(
              onTap: (){
                Provide.value<CartProvide>(context).buyGoods();
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.red,
                child: Text(
                  '马上购买',
                  style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(28)),
                ),
              ) ,
              ),
            )
          ],
        ),
      );
    });
   
  }
}