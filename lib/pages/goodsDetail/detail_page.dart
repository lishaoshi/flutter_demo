


import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/goods_detail_info.dart';
import 'package:flutter_app/config/application.dart';
import 'package:flutter_app/pages/goodsDetail/components/detailTopImg.dart';
import 'package:flutter_app/pages/goodsDetail/detailModel.dart';
import 'package:flutter_app/pages/goodsDetail/components/instructions.dart';
import 'package:flutter_app/pages/goodsDetail/components/detailTabBar.dart';
import 'package:flutter_app/pages/goodsDetail/components/goodSDetailP.dart';
import 'package:flutter_app/pages/goodsDetail/components/DetailBottom.dart';


class DetailPage extends StatefulWidget {
  final String goodsId;
  DetailPage({Key key, this.goodsId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  //调用查询商品详情接口
  Future getGoodsDetailInfo(BuildContext context) async{
    await  Provide.value<DetailPagePrvide>(context).getGoodsDetailFnc(widget.goodsId);
    return '请求结束';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            print('返回上一页');
            // Navigator.pop(context);
            Application.router.pop(context);
          },
        ),
      ),
      // body: Text('GoodsId: ${widget.goodsId}'),
      body:FutureBuilder(
        future: getGoodsDetailInfo(context),
        builder: (context, asyncSnapshot) {
          if(asyncSnapshot.hasData) {
            // print(asyncSnapshot);
            return Stack(
              children: <Widget>[
                ListView(
                  children: [
                    GoodsDEtailTopBox(),
                    Instructions(),
                    MyTabBar(),
                    GoodsDeail(),
                    // Stack(
                    //   children: <Widget> [
                    //     Positioned(
                    //       left: 0,
                    //       bottom: 0,
                    //       child: Text('底部')
                    //     )
                    //   ],
                    // )
                  ]
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: DetailBottom()
                )
              ],
            );
          } else {
            return Text('正在刷新。。。');
          }
        }
      ),
    );
  }
}