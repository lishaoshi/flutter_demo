import 'package:flutter/material.dart';
import 'package:flutter_app/provide/count.dart';
import 'package:provide/provide.dart';
import '../../provide/count.dart';


class MyPage extends StatelessWidget {
  const MyPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 100),
        child: Center(
          child: Provide<Counter>(builder: (context, child, counter){
              return Text('${counter.value}',style: TextStyle(fontSize: 28));
            },
          ),
        ) ,
    ),
    );
  }
}