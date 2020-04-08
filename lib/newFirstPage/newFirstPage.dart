import 'package:flutter/material.dart';
import 'package:flutter_app/pages/bottomNavigotes/shoppingCart.dart';
import 'package:provide/provide.dart'; 
import '../pages/bottomNavigotes/home_page.dart';
import '../pages/bottomNavigotes/class_page.dart';
import '../pages/bottomNavigotes/my_page.dart';
// import '../pages/bottomNavigotes/find_page.dart';
import 'package:flutter_app/provide/homeProvide.dart';

class NewPage extends StatelessWidget {
  //  void _onTap(context, index, currentIndex) {
  //   if(index == currentIndex) {
  //     return;
  //   }
  // }
  /*
  定义底部跳转状态栏
   */
    final List<BottomNavigationBarItem> bottomTap = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('首页')
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        title: Text('分类')
      ),
      // BottomNavigationBarItem(
      //   icon: Icon(
      //     Icons.find_in_page,
      //   ),
      //   title: Text('发现')
      // ),
      BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart),
        title: Text('购物车')
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_pin),
        title: Text('我的')
      )
    ];
    //当前页面的index
    // int currenIndex = 0;
    /*
     *定义要跳转的页面list 
     */
    final List<Widget> targetPage = [
      HomePage(),
      ClassPage(),
      // FindPage(),
      CartPage(),
      MyPage(),
    ];
  @override 
  Widget build(BuildContext context) {
    // int currentIndex = Provide.value<HomeProvide>(context).bottomIndex;
    return Provide<HomeProvide>(builder: (context, child, val){ 
      return Scaffold(
        body: Container(
          child: IndexedStack(
            index: val.bottomIndex,
            children: targetPage
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomTap,
          currentIndex: val.bottomIndex,
          onTap: (int tapIndex) {
            print(tapIndex);
            // _onTap(context, tapIndex, val.bottomIndex);
            if(tapIndex == val.bottomIndex) {
              return;
            }
            Provide.value<HomeProvide>(context).changeBottomIndex(tapIndex);
          },
          fixedColor: Color.fromARGB(233, 233, 188, 157),
          unselectedItemColor: Colors.red,
          type: BottomNavigationBarType.fixed,
        ),
      );});
  }
}
