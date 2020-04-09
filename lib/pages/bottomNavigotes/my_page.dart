import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget/animationWidget.dart';
import 'package:flutter_app/widget/StaggerAnimation.dart';


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
    animation = Tween(begin: 0.0, end: 300.0).animate(_animationController);
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
          // labelPadding: EdgeInsets.only(left: 20.0),
          // indicatorColor: Colors.red,
          // indicatorWeight : 0.2,
          // indicator: BoxDecoration(
          //   color: Colors.blue
          // ),
          // indicatorSize: TabBarIndicatorSize.tab,
          dragStartBehavior: DragStartBehavior.start, 
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
           child:AnimationWidget(animation: animation,)
         ),
          HeroAnimationRoute(),
            StaggerRoute(),
             Text('4'),
              Text('5'),
               Text('6'),
        ],
      )
    );
  }
}


// 路由A
class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      child: InkWell(
        child: Hero(
          tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
          child: ClipOval(
            child: Image.asset("assets/images/text.jpg",
              width: 50.0,
            ),
          ),
        ),
        onTap: () {
          //打开B路由  
          Navigator.push(context, PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation animation,
                  Animation secondaryAnimation) {
                return new FadeTransition(
                  opacity: animation,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Text("原图"),
                    ),
                    body: HeroAnimationRouteB(),
                  ),
                );
              })
          );
        },
      ),
    );
  }
}


class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
          tag: "avatar", //唯一标记，前后两个路由页Hero的tag必须相同
            child: Image.asset("assets/images/text.jpg"),

      ),
    );
  }
}




class StaggerRoute extends StatefulWidget {
  @override
  _StaggerRouteState createState() => _StaggerRouteState();
}

class _StaggerRouteState extends State<StaggerRoute> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 2000),
        vsync: this
    );
  }


  Future<Null> _playAnimation() async {
    try {
      
      //先正向执行动画
      await _controller.forward();
      //再反向执行动画
      await _controller.reverse();
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      // behavior: HitTestBehavior.opaque,
      onTap: () {
        _playAnimation();
      },
      child: Center(
        child: Container(
          width: 300.0,
          height: 300.0,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            border: Border.all(
              color:  Colors.black.withOpacity(0.5),
            ),
          ),
          //调用我们定义的交织动画Widget
          child: StaggerAnimation(
              controller: _controller
          ),
        ),
      ),
    );
  }
}