import 'package:flutter/material.dart';


class HomeProvide with ChangeNotifier {

  //当前底部tab栏激活的index
  int bottomIndex = 0;

  //修改bottomIndex方法
  changeBottomIndex(int index) {
    print('provide $index');
    bottomIndex = index;
    notifyListeners();
  }
}