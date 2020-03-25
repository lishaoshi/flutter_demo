// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/sevice/request.dart';
import '../../sevice/home_page.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
// import '';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
 
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  @override
  // bool get wantKeepAlive=>true;
  Map formData = {'lon':'115.02932','lat':'35.76189'};
  int page = 1;
  List<Map> goodsList=[];
  EasyRefreshController _controller = EasyRefreshController();
  // GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
  CustomFooter customFooter = CustomFooter(
                                completeDuration: Duration(seconds: 3),
                                enableHapticFeedback: true,
                                footerBuilder: (context, loadMode, doub1, d2, d3, axisDirection, bol1, time, bol2, bol3, bol4) {
                                  return Text('正在加载R');
                                }
                              );
  //获取火热商品
  void _getHotGoodls(listPageData) async {
    await hotGoods(formData:listPageData).then((val) {
      var data = json.decode(val);
      List<Map> goodsListData = [];
      // debugger();
      if(data['data']!=null&&data['data'].length>0) {
        goodsListData = (data['data'] as List).cast();
      } else {
        goodsListData = [];
      }
      setState(() {
        goodsList.addAll(goodsListData);
        page++;
      });
       _controller.finishLoad(success: true, noMore: goodsListData.length==0?true:false);
    });
  }
  @override
  void initState() { 
    super.initState();
    Map listPageData = {
      'page': page,
    };
    // customFooter();
    _getHotGoodls(listPageData);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // dio.dispose();
  }
  

  
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
        backgroundColor: Colors.redAccent[700],
      ),
      body: Container(
        child:  FutureBuilder(
          future: homeDataContent(formData:formData),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiperList = (data['data']['slides'] as List).cast();
              List<Map> navigatorList = (data['data']['category'] as List).cast();
              String imgUrl = data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String telImgUrl = data['data']['shopInfo']['leaderImage'];
              // String telPhone = data['data']['shopInfo']['leaderPhone'];
              String telPhone = '13283820349';
              List<Map> recommendShopList = (data['data']['recommend'] as List).cast();
              return EasyRefresh(
                controller: _controller,
                // refreshFooter: ClassicsFooter(),
                topBouncing: false,
                footer: MaterialFooter(
                  backgroundColor: Colors.pink,
                  // valueColor: Colors.black12,
                  // valueColor: Animation()
                ),
                child: ListView(
                  children: [
                    HomeSwiper(swiperDataList:swiperList),
                    TagetNavigator(navigatorListData:navigatorList),
                    AdBanner(imgUrl:imgUrl),
                    TelCallImg(telImgUrl: telImgUrl, telPhone: telPhone),
                    RecommendShop(recommendShopList: recommendShopList),
                    HotGoodsList(goodsList:goodsList)
                  ],
                ),
                enableControlFinishLoad: true,
                onLoad:() async{
                    this.page++;
                    await Future.delayed(Duration(seconds: 2), (){
                      if(mounted) {
                        print('mount');
                        // print(mounted);
                        _getHotGoodls({"page": this.page});   
                      }
                    });
                },
                // footer: MaterialFooter(),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation(Colors.pink),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

/*
*轮播图 
*/
class HomeSwiper extends StatelessWidget {
  //导航文字字段： mallCategoryName
  final List swiperDataList;
  HomeSwiper({Key key, this.swiperDataList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ScreenUtil.init(context, width: 750, height: 1334);
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index){
          return Image.network('${swiperDataList[index]['image']}', fit: BoxFit.fill,);
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        controller: SwiperController(),
        autoplay: true
      ),
    );
  }
}
/*
 * 导航列表
 */
class TagetNavigator extends StatelessWidget {
  final List navigatorListData;
  TagetNavigator({Key key, @required this.navigatorListData}) : super(key: key);
  Widget _itemClomunView(BuildContext context, item) {
    return InkWell(
      onTap: (){print('点击了导航');},
      child: Column(
        children: [
          Image.network(item['image'], width: ScreenUtil().setWidth(95),),
          Text(item['mallCategoryName'])
        ]
      ),
    );
  }
  @override 
  Widget build(BuildContext context) {
    if(this.navigatorListData.length > 0) {
      this.navigatorListData.removeRange(10, this.navigatorListData.length);
    }
    var data = navigatorListData.map((item){
      return _itemClomunView(context, item);     
    }).toList();
    return Container(
      height: ScreenUtil().setWidth(320),
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        children: data,
        padding: EdgeInsets.all(5.0),
        ),
    );
  }
}

/*
 *广告banner
 */
class AdBanner extends StatelessWidget {
  final String imgUrl;
  const AdBanner({Key key, @required this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(imgUrl),
    );
  }
}

/*
 *拨打电话
 */
class TelCallImg extends StatelessWidget {
  final String telImgUrl;
  final String telPhone;
  const TelCallImg({Key key, @required this.telImgUrl, @required this.telPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _launchURL() async {
      final url = 'tel:'+telPhone;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    return Container(
      child: InkWell(
        child: Image.network(telImgUrl),
        onTap: _launchURL,
      ) 
      
    );
  }
}

/*
 *推荐商品 
 */
class RecommendShop extends StatelessWidget {
  final List recommendShopList;
  const RecommendShop({Key key, @required this.recommendShopList}) : super(key: key);

  //标题方法
  Widget _titleView() {
    return Container(
      child: Text('商品推荐',textAlign: TextAlign.center,style: TextStyle(color:Colors.red),),
      padding: EdgeInsets.fromLTRB(10.0, 8.0, 5.0, 8.0),
      height: ScreenUtil().setHeight(60),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        // color: Colors.blue,
        border: Border(
          bottom: BorderSide(color:Colors.black12)
        )
        
      ),
    );
  }


  //单个商品方法
  Widget _itemShopView(index) {
    return Container(
      height: ScreenUtil().setHeight(300),
      width: ScreenUtil().setWidth(250),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.black12)
        )
      ),
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.network(recommendShopList[index]['image']),
          // Container(
          //   child: Column(
              
          //   )
          // )
          Column(
            children: <Widget>[
              Text('￥456.00'),
              Text('￥567.00',
              style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 12.0,
                color: Colors.black12,
              ),),
            ],
          )
        ],
      ),
    );
  }
  //整个推荐商品方法
  Widget _allShopView() {
    return InkWell(
      onTap:() {},
      child:Container(
        height: ScreenUtil().setHeight(300),
        
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendShopList.length,
          itemBuilder: (context, index) {
            return _itemShopView(index);
          }
        )
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        children: [
          _titleView(),
          _allShopView()
        ]
      ),
    );
  }
}



//火热商品标题
Widget hotTitle = Container(
  child: Text('火热商品12', style: TextStyle(color: Colors.pink),),
  padding: EdgeInsets.all(5.0),
  alignment: Alignment.center,
);

//火热商品方法
class HotGoodsList extends StatefulWidget {
  final List<Map> goodsList;
  HotGoodsList({Key key, @required this.goodsList}) : super(key: key);

  @override
  _HotGoodsListState createState() => _HotGoodsListState();
}

class _HotGoodsListState extends State<HotGoodsList> {

  Widget _wrapList() {
    if(widget.goodsList.length > 0) {
      List<Widget> listWidget = widget.goodsList.map((item) {
        return InkWell(
          onTap: (){},
          child: Container(
            padding: EdgeInsets.all(5.0),
            width: ScreenUtil().setWidth(372),
            child: Column(
              children: <Widget>[
                Image.network(item['image'],width: ScreenUtil().setWidth(375)),
                Text(
                  item['name'],
                  maxLines: 1,
                  overflow:TextOverflow.ellipsis ,
                  style: TextStyle(color:Colors.pink,fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${item['mallPrice']}'),
                    Text(
                      '￥${item['price']}',
                      style: TextStyle(color:Colors.black26,decoration: TextDecoration.lineThrough),

                    )
                  ],
                )
              ]
            ),
          ),
        );
      }).toList();
       return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        hotTitle,
        _wrapList()
      ]
    );
  }
}





