import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'networkUtil.dart';
import 'dataJson.dart';
import 'dart:convert';
class itemPage extends StatefulWidget{
  itemPage({Key key,this.title,this.item}):super(key:key);
  final String title;
  final json_itemInfo item;
  @override
  _itemPageState createState() => _itemPageState();

}
class _itemPageState extends State<itemPage>
{
    @override
    Widget build(BuildContext context) {
      Image itemTexture =
      new Image.memory(base64Decode(widget.item.base64encTexture),scale: 1.3,);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.brown,
            centerTitle: true,
            bottom: new PreferredSize(
                preferredSize: const Size.fromHeight(128.0),
                child: new Column(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      child: itemTexture,
                    ),
                    new Text(
                      widget.item.itemName,
                      textScaleFactor: 2.0,
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
                  new Text("Modname:"+widget.item.modName,style: new TextStyle(fontSize: 20),),
                  new Text(""),
                  new Text(
                    "ItemInfo:"+
                    widget.item.commentInfo,
                    maxLines: null,
                    style:new TextStyle(
                      fontSize: 20.0,
                    )
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}
