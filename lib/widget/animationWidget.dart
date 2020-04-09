import 'package:flutter/material.dart';

class AnimationWidget extends StatelessWidget {
  const AnimationWidget({Key key, Animation<double> this.animation}) : super(key: key);
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    // final Animation<double> animation = listenable;
    // Container(
    //   child: Center(
    //     child:  Image.asset("assets/images/text.jpg",
    //          excludeFromSemantics : true,
    //       width: animation.value, height: animation.value)
    //   ),
    // );
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Center(
          child: Container(
            width: animation.value,
            height: animation.value,
            child: child
          ),
        );
      },
      child: Image.asset("assets/images/text.jpg"),
    ); 
  }
}