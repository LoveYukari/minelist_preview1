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
  MenuItemPage({Key key, this.searchList, this.category}) : super(key: key);
  final List<json_itemInfo> searchList;
  final String category;
  @override
  _MenuItemPageState createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {
  @override
  Widget build(BuildContext context) {
     menuItemListViewItemBuilder(BuildContext context, int count) {
      json_itemInfo itemInfo = widget.searchList[count];
      final item = widget.searchList[count];
      TextStyle textStyle =
      new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);
      Image itemTexture =
      new Image.memory(base64Decode(itemInfo.base64encTexture));
      return new ListTile(
            title: Text(widget.searchList[count].itemName),
            subtitle: Text(widget.searchList[count].modName),
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
          itemCount: widget.searchList.length,
          itemBuilder: menuItemListViewItemBuilder,
        ));
  }
}
