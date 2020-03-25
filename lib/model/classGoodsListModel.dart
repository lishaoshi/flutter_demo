

class ClassGoodsListModel {
  String code;
  String message;
  List<ClassGoodsData> data;

  ClassGoodsListModel(this.code, this.message, this.data);

  ClassGoodsListModel.formJson(Map json) {
    code = json['code'];
    message = json['message'];
    if(json['data'] != null) {
      data = new List<ClassGoodsData>();
      // data.addAll(json['data']);
      json['data'].forEach((v) {
        data.add(new ClassGoodsData.fromJson(v));
      });
    }
  }
}

class ClassGoodsData {
  String image;
  double oriPrice;
  double presentPrice;
  String goodsName;
  String goodsId;

  ClassGoodsData(
    this.image, 
    this.oriPrice, 
    this.presentPrice, 
    this.goodsName,
    this.goodsId);
  
  ClassGoodsData.fromJson(Map json) {
    image = json['image'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
  }
}