import 'package:flutter/material.dart';
import 'package:flutter_app/model/catogegryModel.dart';


class ClassData with ChangeNotifier {
  List<BxMallSubDto> topClassList = [];

  settopListData(List list) {
    topClassList = list;
    notifyListeners();
  }
}