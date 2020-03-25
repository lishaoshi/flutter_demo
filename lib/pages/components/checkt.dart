import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//自定义裁剪
//自定义裁剪组件不会影响组件得宽高
class MyClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTWH(10.0, 15.0, 40.0, 30.0);

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}


class CheckW extends StatelessWidget {
  bool flag;
  final Function  callbacks;
  CheckW({Key key, this.flag, this.callbacks}) : super(key: key);

  // bool _flag = flag;
  // final bool _checkoFlag = flag;
  // void _changeFlag

  @override
  Widget build(BuildContext context) {
    bool _flag = flag;
    return Container(
      // color: Colors.red,
      child: Checkbox(
          activeColor: Colors.pink,
          value: _flag,
          onChanged: (value) {
            _flag = value;
            callbacks(context, value);
          },
      // ),
      )
    );  
  }
}