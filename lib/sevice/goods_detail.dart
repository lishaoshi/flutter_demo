import './request.dart';

// 获取商品详情页
Future homeDataContent({formData}) {
  // print('开始请求数据123456');
  return request('wxmini/getGoodDetailById', formData: formData);
}
