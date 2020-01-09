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
  _goNewRouter(context) {
    Navigator.push(context, 
    MaterialPageRoute(
      builder: (context)=> newRouter()
    ));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('$pageName'),
      ),
      body: (
        Center(
          child: Column(
            children: <Widget>[
              _scrollListView( items: List.generate(500, (index)=>'this is try new widget $index')),
             
            ],
          )
        )
      ),
      floatingActionButton:  FloatingActionButton.extended(
                onPressed: () {
                  _goNewRouter(context);
        // Add your onPressed code here!
                },
                label: Text('Approve'),
                icon: Icon(Icons.thumb_up),
                backgroundColor: Colors.pink,
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

class newRouter extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 100.0,
          height: 100.0,
          child:Image.asset('assets/images/text.jpg')
        )
      ),
      body: _newRouterPage(),
    );
  }
}

class _newRouterPage extends StatelessWidget {
  final List<Widget> infoList = [
    Container(
      child: Column(
        children: <Widget>[
          Text(
            'this is Text orer',
            style: TextStyle(
              fontSize: 32.0
            ),
          ),
          Text('this is Text firesr')
        ],
      ),
    )
  ];
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.0),
      child: Row(
        children: infoList,
      ),
    );
  }
}