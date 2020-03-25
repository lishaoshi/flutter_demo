
import './request.dart';


// 获取pageHome数据
Future homeDataContent({formData}) {
  // print('开始请求数据123456');
  return request('wxmini/homePageContent', formData: formData);
}

//商城首页热卖数据
Future hotGoods({formData}) {
  return request('wxmini/homePageBelowConten',formData: formData);
}