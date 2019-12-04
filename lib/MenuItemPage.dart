import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minelist_preview1/ItemPage.dart';
import 'package:minelist_preview1/networkUtil.dart';
import 'package:minelist_preview1/updateItemPage.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

import 'dataJson.dart';

///this is for main.dart's menu 's item it needs a category list to init;
class MenuItemPage extends StatefulWidget {
  MenuItemPage({Key key, this.searchList, this.category,this.user}) : super(key: key);
  final List<json_itemInfo> searchList;
  final String category;
  final json_userInfo user;
  @override
  _MenuItemPageState createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {
  @override
  Widget build(BuildContext context) {
    List<json_itemInfo> innerList = new List();
    try {
      for (var i = 0; i < widget.searchList.length; i++) {
        innerList.add(widget.searchList[i]);
      }
    }
    catch(error)
    {
      print(error.toString());
    }
    Widget AdminMenuItemListViewItemBuilder(BuildContext context, int count) {
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
              onLongPress: (){
                Navigator.push(
                    context,new MaterialPageRoute(builder:
                    (context)=>new updateItemPage(
                  title:itemInfo.itemName,
                  updateItem:itemInfo,
                )
                )
                );
              }
          ),
          //secondaryBackground: Container(color: Colors.pink),
          dragStartBehavior: DragStartBehavior.down,
          direction: DismissDirection.endToStart,
          confirmDismiss: (direction)async{
              try {
                showDialog(context: context,builder: (BuildContext context){
                  return AlertDialog(
                      title:Text("Warning!"),
                      content:Text("Are you sure to Delete,my dear admin?"),
                      actions:[FlatButton(child: Text("YES"),onPressed:(){NetworkUtil.deleteItem(innerList[count]);Navigator.of(context).pop(true);}),
                               FlatButton(child: Text("NO"),onPressed: (){Navigator.of(context).pop(false);},)]
                  );
                });

              }
              catch(error){
              }
                //innerList = await NetworkUtil.getItemInfo_byCategory(widget.category);
          },
      );
    }
    Widget UserMenuItemListViewItemBuilder(BuildContext context,int count)
    {
      json_itemInfo itemInfo = innerList[count];
      final item = innerList[count];
      TextStyle textStyle =
      new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);
      Image itemTexture =
      new Image.memory(base64Decode(itemInfo.base64encTexture));
      return new ListTile(
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
            onLongPress: ()async{
                var resp = await NetworkUtil.userAddfavorites(itemInfo, widget.user);
                print(resp.toString());
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text(itemInfo.itemName+" has add to your favorite!"),
                ));
            }
      );
    }
    Widget VisitorMenuItemListViewItemBuilder(BuildContext context,int count)
    {
      json_itemInfo itemInfo = innerList[count];
      final item = innerList[count];
      TextStyle textStyle =
      new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);
      Image itemTexture =
      new Image.memory(base64Decode(itemInfo.base64encTexture));
      return new ListTile(
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
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: new Text(widget.category),
          backgroundColor: Colors.blueAccent,
        ),
        body: new ListView.builder(
          padding: new EdgeInsets.all(3.0),
          itemExtent: 60.0,
          itemCount: innerList.length,
          itemBuilder: (context,itemCount){
            if(widget.user.userAuthority=="1")return VisitorMenuItemListViewItemBuilder(context,itemCount);
            if(widget.user.userAuthority=="2")return UserMenuItemListViewItemBuilder(context, itemCount);
            if(widget.user.userAuthority=="3")return AdminMenuItemListViewItemBuilder(context, itemCount);
            return null;
          },
        ));
  }
}
