// import 'dart:developer';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/provide/classList.dart';
import 'package:flutter_app/model/catogegryModel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../sevice/class_page.dart';
import 'dart:convert';
import 'package:provide/provide.dart';
import '../../model/classGoodsListModel.dart';
import '../../config/application.dart';
import '../goodsDetail/detail_page.dart';


class ClassPage extends StatefulWidget {
  ClassPage({Key key}) : super(key: key);

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  int topTableIndex = 0;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
      appBar: AppBar(
        title: Text('类别'),
        backgroundColor: Colors.pink,
      ),
      body: Container(
        width: ScreenUtil().setWidth(750),
        child:Row(
          // direction: Axis.horizontal,
          children: <Widget>[
            LeftNavigation(),
            Column(
              children: <Widget>[
                ClassTypeTopTitle(),
                ClassListBody()
              ]
            )
          ]
        ),
      ),
    );
  }
}

class LeftNavigation extends StatefulWidget {
  LeftNavigation({Key key}) : super(key: key);

  @override
  _LeftNavigation createState() => _LeftNavigation();
}

class _LeftNavigation extends State<LeftNavigation> {
   List list = [];
   int currentIndex = 0;
   bool isClick = false;

   Future _getClassData({data}) async{
      await getClassData().then((val) {
        var data = json.decode(val);
       ClassPageModel classData = ClassPageModel.fromJson(data);
       setState(() {
         list = classData.data;
         Provide.value<ClassData>(context).settopListData(list[0].bxMallSubDto);
       });
      });
   }
   @override
   void initState() { 
     super.initState();
     _getClassData();
   }
  //单个itemview
  Widget _itemView(int index) {
    isClick=currentIndex==index?true:false;
    return InkWell(
      onTap: (){
        // initTopData(index);
        List classTopDataList = [];
        setState(() {
          currentIndex=index;
          classTopDataList = list[currentIndex].bxMallSubDto;
          Provide.value<ClassData>(context).settopListData(classTopDataList);
        });
      },
      child: Container(
        height: ScreenUtil().setHeight(80.0),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 14.0),
        child: Text(list[index].mallCategoryName),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12)
          ),
          color: isClick?Colors.black12:Colors.white
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: ListView.builder(
        itemCount: list.length,
        reverse: false,
        itemBuilder: (context, index) {
          return _itemView(index);
        },
      ),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black12)
        )
      ),
    );
  }
}

/*
 *右边展示——头部分类
 */
class ClassTypeTopTitle extends StatefulWidget {
  // int topTableIndex;
  ClassTypeTopTitle({Key key, }) : super(key: key);

  @override
  _ClassTypeTopTitleState createState() => _ClassTypeTopTitleState();
}

class _ClassTypeTopTitleState extends State<ClassTypeTopTitle> {
  int topTableIndex = 0;
  //头部title类别
  Widget topTitleItem(BxMallSubDto item, int index) {
    return InkWell(
      onTap: () {
        // 
        setState(() {
          topTableIndex = index;
        });
        print(topTableIndex);
      },
      child: Container(
        // width: ScreenUtil().setWidth(100),
        height: ScreenUtil().setWidth(80),
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(8.0,5.0,8.0,5.0),
        child: Text(
          '${item.mallSubName}',
          style: TextStyle(
            color: index == topTableIndex?Colors.pink:Colors.black38
          ),),
      ),
      
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(550),
      height: ScreenUtil().setHeight(80),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12)
        )
      ),
      child:  Provide<ClassData>(
          builder:(context, child, classData) {
            return  Container(
              height: ScreenUtil().setHeight(80),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: classData.topClassList.length,
                itemBuilder: (context, index) {
                  return topTitleItem(classData.topClassList[index], index);
                },
              ),
              // child: Text('$classData'),
            );
          }
        ),
    );
  }
}

/*
 *右边展示——主体部分 
 */
class ClassListBody extends StatefulWidget {
  
  ClassListBody({Key key}) : super(key: key);

  @override
  _ClassListBodyState createState() => _ClassListBodyState();
}

class _ClassListBodyState extends State<ClassListBody> {
  final List goodsList = [];
  @override
  void initState() { 
    super.initState();
    getGoodsList(categoryId:'4', categorySubId: '2c9f6c94621970a801626a35cb4d0175');
  }
  Future getGoodsList({String categoryId, String categorySubId}) async{
    var data = {
      'categoryId': categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };
    await getClassGoodsList('wxmini/getMallGoods', data).then((val) {
      // print('商品列表为： ${val.toString()}');
      var data = json.decode(val);
      ClassGoodsListModel goodsListModel = ClassGoodsListModel.formJson(data);
      print('>>>>:: $goodsListModel');

      setState(() {
        goodsList.addAll(goodsListModel.data);
      });
    });
  }


  Widget _wrapGoodsList() {
    if(goodsList.length > 0) {
      List<Widget> _goodsList = goodsList.map((item) {
        return _itemGoodsView(item);
      }).toList();
      return Container(
        width: ScreenUtil().setWidth(550),
        child: Wrap(
            spacing: 2,
            children: _goodsList,
          ),
        );
    } else {
      return Center(
        child: Text('暂无数据。。。')
      );
    }
  }


  //单个商品view 
  Widget _itemGoodsView(item) {
    return Container(
      width: ScreenUtil().setWidth(270),
      padding: EdgeInsets.all(4.0),
      child: InkWell(
        onTap: (){
        //  Navigator.push(context, 
        //   MaterialPageRoute(builder:(context){
        //     return DetailPage(goodsId: item.goodsId,);
        //   })
        //  );
        // print(item.goodsId);
        Application.router.navigateTo(context, '/goods_detail?id=${item.goodsId}',
          transitionDuration: Duration(milliseconds :100),
          transition: TransitionType.fadeIn
        );
        },
        child:Column(
          children: <Widget>[
            // Container(),
            Image.network('${item.image}', 
              width: ScreenUtil().setWidth(220),
              height: ScreenUtil().setHeight(220),
            //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
            //   if (loadingProgress == null)
            //     return child;
            //   return Center(
            //     child: CircularProgressIndicator(
            // goodsId"|W#"||# != null
            //           ? loadingProgress.cumuRlativeBytesLoaded / loadingProgress.expectedTotalBytes
            //           : null,
            //     ),
            //   );
            // }),
            ),
            Text('${item.goodsName}',
            overflow: TextOverflow.ellipsis,),
            Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Text('${item.presentPrice}'),
                Text('${item.oriPrice}',style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black12))
              ],
            )
          ]
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
      width: ScreenUtil().setWidth(550),
      child: ListView(
        children: [
          _wrapGoodsList()
        ]
      ),
    ),
    );
  }
}