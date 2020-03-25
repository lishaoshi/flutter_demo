import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_app/provide/goods_detail_info.dart';



class MyTabBar extends StatelessWidget {
  const MyTabBar({Key key}) : super(key: key);


  Widget onLeft(BuildContext context, bool flag) {
    return InkWell(
      onTap: () {
        Provide.value<DetailPagePrvide>(context).changeFlag('left');
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: !flag?Colors.pink:Colors.transparent
            )
          )
        ),
        child: Text('评论',style: TextStyle(fontSize: ScreenUtil().setSp(28.0), color: !flag?Colors.pink:Colors.black12))
      ),
    );
  }

  Widget onRight(BuildContext context, bool flag) {
    return InkWell(
      onTap: () {
        Provide.value<DetailPagePrvide>(context).changeFlag('right');
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: flag?Colors.pink:Colors.transparent
            )
          )
        ),
        child: Text('详情',style: TextStyle(fontSize: ScreenUtil().setSp(28.0), color: flag?Colors.pink:Colors.black12))
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Provide<DetailPagePrvide>(builder: (context, child, val){
      bool leftOrRightFlag = val.leftRightFlag;
      return Container(
        height: ScreenUtil().setHeight(80.0),
        color: Colors.white,
        margin: EdgeInsets.only(top: 20.0),
        child: Flex(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          direction: Axis.horizontal,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          textBaseline: TextBaseline.ideographic,
          children: <Widget> [
            Expanded(
              flex: 1,
              child:onLeft(context, leftOrRightFlag),
            ),
             Expanded(
              flex: 1,
              child:onRight(context,leftOrRightFlag),
            ),
            
            
          ]
        ),
      ); 
    });
  }
}