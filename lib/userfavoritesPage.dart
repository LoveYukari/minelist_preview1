import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minelist_preview1/ItemPage.dart';
import 'package:minelist_preview1/networkUtil.dart';
import 'package:minelist_preview1/updateItemPage.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

import 'dataJson.dart';

///this is for main.dart's menu 's item it needs a category list to init;
class userFavoritesPage extends StatefulWidget {
  userFavoritesPage({Key key, this.searchList,this.user}) : super(key: key);
  final List<json_itemInfo> searchList;
  final json_userInfo user;
  @override
  _userFavoritesPageState createState() => _userFavoritesPageState();
}

class _userFavoritesPageState extends State<userFavoritesPage> {
  @override
  Widget build(BuildContext context) {
    List<json_itemInfo> innerList = new List();
    for(var i=0;i<widget.searchList.length;i++)
    {
      innerList.add(widget.searchList[i]);
    }
    Widget userFavoriteListViewItemBuilder(BuildContext context, int count) {
      json_itemInfo itemInfo = innerList[count];
      final item = innerList[count];
      TextStyle textStyle =
      new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);
      Image itemTexture =
      new Image.memory(base64Decode(itemInfo.base64encTexture));
      return new Dismissible(key:Key(item.toString()),
        child: new ListTile(
            title: Text(innerList[count].itemName),
            subtitle: Text(innerList[count].modName),
            leading: Container(
              width: 60,height: 60,child: itemTexture,
            ),
            onTap: (){
              Navigator.push(
                  context,new MaterialPageRoute(builder:
                  (context)=>new itemPage(
                title:itemInfo.itemName,
                item:itemInfo,
              )
              )
              );
            },
        ),
        //secondaryBackground: Container(color: Colors.pink),
        dragStartBehavior: DragStartBehavior.down,
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction)async{
          print("confirmdissmiss");
          try {
            showDialog(context: context,builder: (BuildContext context){
              return AlertDialog(
                  title:Text("Warning!"),
                  content:Text("Are you sure to Delete?"),
                  actions:[FlatButton(child: Text("YES"),onPressed:(){
                    NetworkUtil.userDeleteFavorites(innerList[count],widget.user);
                    innerList.removeAt(count);
                    Navigator.of(context).pop(true);
                    //Navigator.pop(context);
                  }),
                    FlatButton(child: Text("NO"),onPressed: (){Navigator.of(context).pop(false);})]
              );
            });

          }
          catch(error){
          }
          //innerList = await NetworkUtil.getItemInfo_byCategory(widget.category);
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: new Text("Favorites",),
          backgroundColor: Colors.green,
        ),
        body: new ListView.builder(
          padding: new EdgeInsets.all(3.0),
          itemExtent: 60.0,
          itemCount: innerList.length,
          itemBuilder: userFavoriteListViewItemBuilder,
        )
    );
  }
}
