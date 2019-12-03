import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:minelist_preview1/createItemPage.dart';
import 'package:minelist_preview1/registerPage.dart';
import 'package:minelist_preview1/userListPage.dart';
import 'package:minelist_preview1/userfavoritesPage.dart';
import 'dataJson.dart';
import 'MenuItemPage.dart';
import 'itemPage.dart';
import 'loginPage.dart';
import 'networkUtil.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MineList',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(title: 'MineList Test Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.userInfo}) : super(key: key);

  final String title;
  final json_userInfo userInfo;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    String authorityStr(json_userInfo usr)
    {
      if(usr.userAuthority=="1")return "Visitor";
      if(usr.userAuthority=="2")return "User";
      if(usr.userAuthority=="3")return "Admin";
      return "NULL";
    }
    final header = DrawerHeader(
        padding: EdgeInsets.zero,
        child: new Stack(
          children: <Widget>[
            new Image.asset(
              "assets/images/background2.png",
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            new Align(
              alignment: FractionalOffset.bottomLeft,
              child: Container(
                height: 90,
                margin: EdgeInsets.only(left: 12.0, bottom: 12.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      margin: EdgeInsets.only(left: 6.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(
                            "Name:"+widget.userInfo.userName,
                            style: new TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          //apply db's authority data here
                          new Text(
                            "Access:"+authorityStr(widget.userInfo),
                            style:
                            new TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                          new Text(
                            "ID:"+(widget.userInfo.userID),
                            style:
                            new TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );

    final adminDrawer = Drawer(
            child: ListView(padding: EdgeInsets.zero, children: <Widget>[
              header,
              ListTile(
                leading: Icon(Icons.people),
                title: Text("UserLists"),
                onTap: () async
                {
                  var userList= await NetworkUtil.getAllUserInfo();
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new userListPage(searchList: userList,)));
                },
              ),
              ListTile(
                leading: Icon(Icons.attach_file),
                title: Text("ItemInfos"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                  leading: Icon(Icons.add_box),
                  title: Text("Create Item"),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder:(context)=>new createItemPage(title:"CreateItem"))
                    );
                  }),
              ListTile(
                leading: Icon(Icons.memory),
                title: Text("Register"),
                onTap: () {
                  Navigator.push(context,new MaterialPageRoute(builder: (context)=>new registerPage(title:"Register")));
                },
              ),
              ListTile(
                leading:Icon(Icons.star),
                title: Text("userFavorites"),
                onTap:()async{
                  var searchList = await NetworkUtil.getUserFavorites(widget.userInfo);
                  print(searchList);
                  Navigator.push(context,new MaterialPageRoute(builder: (context)=>new userFavoritesPage(searchList: searchList,user:widget.userInfo)));
                },
              )
            ])
    );
    final userDrawer = Drawer(

      child:ListView(padding:EdgeInsets.zero,children: <Widget>[
        header,
        ListTile(
          leading: Icon(Icons.attach_file),
          title: Text("ItemInfos"),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading:Icon(Icons.star),
          title: Text("userFavorites"),
          onTap:()async{
            var searchList = await NetworkUtil.getUserFavorites(widget.userInfo);
            Navigator.push(context,new MaterialPageRoute(builder: (context)=>new userFavoritesPage(searchList: searchList,user:widget.userInfo)));
          },
        )
      ],)
    );
    final visitorDrawer = Drawer(
        child:ListView(padding:EdgeInsets.zero,children: <Widget>[
          header,
          ListTile(
            leading: Icon(Icons.attach_file),
            title: Text("ItemInfos"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.memory),
            title: Text("Register"),
            onTap: () {
              Navigator.push(context,new MaterialPageRoute(builder: (context)=>new registerPage(title:"Register")));
            },
          ),
        ],)
    );
    Drawer selectdrawer()
    {
      if(widget.userInfo.userAuthority=="1")return visitorDrawer;
      if(widget.userInfo.userAuthority=='2')return userDrawer;
      if(widget.userInfo.userAuthority=='3')return adminDrawer;
      return testheader;
    }
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        backgroundColor: Colors.orange,
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(0),
            child: new Container(
              width: double.infinity,
              height: double.infinity,
              decoration: new BoxDecoration(
                  color: Colors.grey,
                  gradient: LinearGradient(
                    colors: [Colors.cyan, Colors.purpleAccent],
                  )),
            ),
          ),
          new GridView(
            padding: EdgeInsets.all(30),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.85),
            children: <Widget>[
              Column(
                children: <Widget>[
                  FlatButton(
                    child: Image.asset("assets/images/grassblock.png"),
                    onPressed: () async {
                      var list =
                          await NetworkUtil.getItemInfo_byCategory("Blocks");
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MenuItemPage(
                                    searchList: list,
                                    user: widget.userInfo,
                                    category: "Blocks",
                                  )));
                    },
                  ),
                  Text(
                    "Blocks",
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  FlatButton(
                    child: Image.asset("assets/images/Cake.png"),
                    onPressed: () async {
                      var list =
                          await NetworkUtil.getItemInfo_byCategory("Food");
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MenuItemPage(
                                    searchList: list,
                                    category: "Food",
                                    user: widget.userInfo
                                  )));
                    },
                  ),
                  Text(
                    "Food",
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  FlatButton(
                    child: Image.asset("assets/images/Quartz.png"),
                    onPressed: () async {
                      var list =
                          await NetworkUtil.getItemInfo_byCategory("Miscs");
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MenuItemPage(
                                    searchList: list,
                                    category: "Miscs",
                                    user: widget.userInfo
                                  )));
                    },
                  ),
                  Text(
                    "Miscs",
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white, fontSize: 15),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  FlatButton(
                    child: Image.asset("assets/images/DiamondSword.png"),
                    onPressed: () async {
                      var list =
                          await NetworkUtil.getItemInfo_byCategory("Weapons");
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MenuItemPage(
                                    searchList: list,
                                    category: "Weapons",
                                    user: widget.userInfo
                                  )));
                    },
                  ),
                  Text(
                    "Weapons",
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  FlatButton(
                    child: Image.asset("assets/images/RedStone.png"),
                    onPressed: () async {
                      var list =
                          await NetworkUtil.getItemInfo_byCategory("Redstones");
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MenuItemPage(
                                    searchList: list,
                                    category: "Redstones",
                                    user: widget.userInfo
                                  )));
                    },
                  ),
                  Text(
                    "Redstones",
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  FlatButton(
                    child: Image.asset("assets/images/Enchantment.png"),
                    onPressed: () async {
                      var list = await NetworkUtil.getItemInfo_byCategory(
                          "Enchantments");
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MenuItemPage(
                                    searchList: list,
                                    category: "Enchantments",
                                    user: widget.userInfo
                                  )));
                    },
                  ),
                  Text(
                    "Enchantments",
                    textAlign: TextAlign.center,
                    style: new TextStyle(color: Colors.white),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
      drawer: selectdrawer(),
    );
  }
}
/*
class itemPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Testpage"),
            backgroundColor: Colors.brown,
            centerTitle: true,
            bottom: new PreferredSize(
                preferredSize: const Size.fromHeight(128.0),
                child: new Column(
                  children: <Widget>[
                    new Image.asset("assets/images/Andesite.png", scale: 1.4),
                    new Text(
                      "Andesite",
                      textScaleFactor: 1.5,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                    )
                  ],
                ))),
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: new Column(
                children: <Widget>[
                  new Text(
                    "Info:\nType:自然生成\n普通的花岗岩会生成在地表下的任何地方（高度低于80），会以多达33个为一组生成，和其余两种岩石类型以及泥土和沙砾一样。在山地生物群系中会暴露在空气中。磨制花岗岩会生成在一些水下废墟和沙漠村庄的盔甲匠小屋中。在基岩版中，花岗岩会作为珊瑚礁的一部分生成。",
                    maxLines: null,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class subPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget buildItem(BuildContext context, int index) {
      TextStyle textStyle =
          new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);
      List itemNames = [
        "Andesite",
        "Coal",
        "Diorite",
        "Diamond",
        "Granite",
        "IronOre",
        "Obsidian",
        "Planks",
        "Stone",
        "Quartz"
      ];
      List itemImagesUrl = [
        "assets/images/Andesite.png",
        "assets/images/Coal.png",
        "assets/images/Diorite.png",
        "assets/images/Diamond.png",
        "assets/images/Granite.png",
        "assets/images/IronOre.png",
        "assets/images/Obsidian.png",
        "assets/images/Planks.png",
        "assets/images/stone.png",
        "assets/images/Quartz.png"
      ];
      return new ListTile(
        leading: Image.asset(
          itemImagesUrl[index],
          scale: 4,
        ),
        title: Text(itemNames[index]),
        subtitle: Text("Item_Id:$index"),
        onTap: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new itemPage()));
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Blocks"),
        backgroundColor: Colors.black,
      ),
      body: new ListView.builder(
        padding: new EdgeInsets.all(3.0),
        itemExtent: 60.0,
        itemCount: 10,
        itemBuilder: buildItem,
      ),
    );
  }
}
*/
Widget testheader = DrawerHeader(
    padding: EdgeInsets.zero,
    child: new Stack(
      children: <Widget>[
        new Image.asset(
          "assets/images/background2.png",
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ),
        new Align(
          alignment: FractionalOffset.bottomLeft,
          child: Container(
            height: 70.0,
            margin: EdgeInsets.only(left: 12.0, bottom: 12.0),
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new CircleAvatar(
                  backgroundImage: AssetImage("assets/images/herobrine.png"),
                  radius: 35.0,
                ),
                new Container(
                  margin: EdgeInsets.only(left: 6.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        "RaymondHua",
                        style: new TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      //apply db's authority data here
                      new Text(
                        "Admin",
                        style:
                            new TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
