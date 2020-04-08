import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with TickerProviderStateMixin {
  TabController _controller;
  Animation<double> animation;
  AnimationController _animationController;
  ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 6, vsync: this);
    _animationController = AnimationController(duration: Duration(seconds : 8,), vsync: this);
    animation = Tween(begin: 0.0, end: 300.0).animate(_animationController)
    ..addListener((){
      setState(()=>{
       
      });
    });
    _animationController.forward();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _animationController.dispose();
    // _scrollController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
        centerTitle: true,
        flexibleSpace: Text('flexibleSpace'),
        actions: [
          Text('index1'),
          Text('index2'),
          Text('index3'),
        ],
        bottom: TabBar(
          isScrollable: true,
          controller: _controller,
          indicatorColor: Colors.red,
          indicatorWeight : 0.2,
          tabs: <Widget>[
            Tab(
              text: "tab1"
            ),
             Tab(
              text: "tab2"
            ),
             Tab(
              text: "tab3"
            ),
             Tab(
              text: "tab4"
            ),
             Tab(
              text: "tab5"
            ),
             Tab(
              text: "tab6"
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        dragStartBehavior: DragStartBehavior.down,
        // physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
         Container(
           color: Colors.red,
           child:Center(
             child:  Image.asset("assets/images/text.jpg",
             excludeFromSemantics : true,
          width: animation.value, height: animation.value)
           )
         ),
           Text('2'),
            Text('3'),
             Text('4'),
              Text('5'),
               Text('6'),
        ],
      )
    );
  }
}