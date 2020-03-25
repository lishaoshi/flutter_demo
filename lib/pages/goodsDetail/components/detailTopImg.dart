import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/provide/goods_detail_info.dart';



class GoodsDEtailTopBox extends StatelessWidget {
  const GoodsDEtailTopBox({Key key}) : super(key: key);

  //顶部图片编写
  Widget topImg(String url) {
    return Image.network(url,
    width: ScreenUtil().setWidth(740),
    );
  }

  //商品名称
  Widget goodsName (String name) {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      height: ScreenUtil().setHeight(60.0),
      alignment: Alignment.centerLeft,
      child: Text('$name',
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(32.0),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //商品编号
  Widget goodsNum(String number) {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Text('编号：$number',
        style: TextStyle(
          color: Colors.black12,
          fontSize: ScreenUtil().setSp(24.0)
        ),
      ),
    );
  }

  //商品价格
  Widget goodsPrice(double price, double oldPrice) {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      width: ScreenUtil().setWidth(730),
      alignment: Alignment.centerLeft,
      child: Flex(
        direction: Axis.vertical,
       children: <Widget>[
         Text('￥${price}',
          style: TextStyle(
            color: Colors.pink,
            fontWeight: FontWeight.bold,
            fontSize: ScreenUtil().setSp(32.0)
          ),
         ),
        //  Text('')
       ], 
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // var url = Provide
    return Provide<DetailPagePrvide>(builder: (context, child, val) {
      var goodsInfo = val.goodsDetailInfo.data.goodInfo;
       if(goodsInfo != null) {
      return Container(
        color: Colors.white,
        padding: EdgeInsets.all(2.0),
        child: Column(
          children: [
            topImg(goodsInfo.image1),
            goodsName(goodsInfo.goodsName),
            goodsNum(goodsInfo.goodsSerialNumber),
            goodsPrice(goodsInfo.presentPrice,goodsInfo.oriPrice)
          ])
      );
    } else {
      return Text('');
    }
    });
    
   
  }
}