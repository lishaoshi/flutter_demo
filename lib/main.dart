import 'package:flutter/material.dart';

void main() => runApp(myApp());



class myApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: appHomePage(
      ),
    );
  }
}


class appHomePage extends StatelessWidget {
  
  @override
  appHomePage({Key key}):super(key:key);
  String pageName = "home Page";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('$pageName'),
      ),
      body: (
        Center(
          child: Column(
            children: <Widget>[
              _scrollListView( items: List.generate(500, (index)=>'this is try new widget $index'))
            ],
          )
        )
      ),
    );
  }
}

class _scrollListView extends StatelessWidget {
  final List<String> items;
  _scrollListView({Key key, @required this.items}):super(key:key);
  Widget build(BuildContext context) {
    return  Container(
      height: 600.0,
      width: 100.0,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text('${items[index]}')
          );
        }
      )
    );
  }
}

class goNewGridPage extends StatelessWidget {

}