import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_app/provide/goods_detail_info.dart';
import 'package:flutter_html/flutter_html.dart';


class GoodsDeail extends StatelessWidget {
  const GoodsDeail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider.value<DetailPagePrvide>(context).
    return Container(
      child: Provide<DetailPagePrvide>(builder: (context, child, val){
        return Column(
          children: <Widget>[
            Offstage(
              offstage: val.leftRightFlag,
              child:  Html(
                data: val.goodsDetailInfo.data.goodInfo.goodsDetail,
              ),
            ),
            Offstage(
              offstage: !val.leftRightFlag,
              child:  Container(
                height: 80.0,
                alignment: Alignment.center,
                child: Text('暂无评论。。。'),
              )
            )
          ],
        );
      }),
    );
  }
}