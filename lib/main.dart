import 'package:flutter/material.dart';
import 'package:flutter_app/provide/cartProvide.dart';
import 'package:flutter_app/provide/classList.dart';
import './newFirstPage/newFirstPage.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import './provide/count.dart';
import './provide/classList.dart';
import './provide/goods_detail_info.dart';
import 'package:fluro/fluro.dart';
import './config/application.dart';
import './routers/routers.dart';
import './provide/homeProvide.dart';
/*
 * flutter 项目的入口文件
 */
void main() {
  
 
  // Routes.configureRoutes(router);
  var classData =  ClassData();
   final providers = Providers()
    ..provide(Provider.function((context) => Counter(0)))
    ..provide(Provider.function((context) =>classData))
    ..provide(Provider.function((context) =>DetailPagePrvide()))
    ..provide(Provider.function((context) =>CartProvide()))
    ..provide(Provider.function((context) =>HomeProvide()));
      runApp(ProviderNode(
        providers: providers,
        child: MyApp(),
      ));
}

//继承NavigatorObserver
class MyObserver extends NavigatorObserver{ 
  @override
  void didPush(Route route, Route previousRoute) {
    // 当调用Navigator.push时回调
    super.didPush(route, previousRoute);
    //可通过route.settings获取路由相关内容
    //route.currentResult获取返回内容
    //....等等
    print(route.settings.name is String);
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Router router = Router();
    Application.router = router;
    Routers.configureRoutes(router);
    // ScreenUtil.init(context, width: 750, height: 1334);
    return Container(
      // margin: EdgeInsets.only(left: 50),
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false,
        home: NewPage(),
        onGenerateRoute: Application.router.generator,
        // onUnknownRoute: (RouteSettings settings){
        //   print(settings);
        // },
        navigatorObservers: [
          MyObserver()
        ],
        color: Colors.pink,
        theme: ThemeData(
          // backgroundColor: Colors.pink,
          primaryColor: Colors.pink,
          // // primarySwatch: MaterialColor(),
          // primaryColorLight: Colors.red,
          // primaryColorDark: Colors.yellow,
          // hintColor: Colors.red,
          // cursorColor: Colors.red,
          accentColor: Colors.pink
        ),
      ),
    );
  }
}