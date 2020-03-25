import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Instructions extends StatelessWidget {
  const Instructions({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.only(left: 15.0),
      height: ScreenUtil().setHeight(60.0),
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: Text(
        '说明：> 急速送达 > 正品保证',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: ScreenUtil().setSp(32.0),
          color: Colors.pink
        ),
      ),
    );
  }
}