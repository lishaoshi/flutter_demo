import 'package:flutter/material.dart';
import 'package:flutter_app/pages/bottomNavigotes/shoppingCart.dart'; 
import '../pages/bottomNavigotes/home_page.dart';
import '../pages/bottomNavigotes/class_page.dart';
import '../pages/bottomNavigotes/my_page.dart';
import '../pages/bottomNavigotes/find_page.dart';

class NewPage extends StatefulWidget {
  @override
  State<NewPage> createState() =>_NewPage();
}

class _NewPage extends State<NewPage> {
  void _onTap(index) {
    if(index == currenIndex) {
      return;
    }
    setState(() {
      currenIndex = index;
    });
  }
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
    int currenIndex = 0;
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
    return Scaffold(
      body: Container(
        child: IndexedStack(
          index: currenIndex,
          children: targetPage
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomTap,
        currentIndex: currenIndex,
        onTap: _onTap,
        fixedColor: Color.fromARGB(233, 233, 188, 157),
        unselectedItemColor: Colors.red,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}