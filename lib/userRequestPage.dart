import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:minelist_preview1/ItemPage.dart';
import 'package:minelist_preview1/networkUtil.dart';
import 'package:minelist_preview1/updateItemPage.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'dataJson.dart';

class userRequestPage extends StatefulWidget
{

   userRequestPage({Key key,this.title,this.reqInfo,this.reqDetail}):super(key:key);
   final String title;
   final List<json_requestInfo> reqInfo;
   final List<json_requestDetail> reqDetail;
   _userRequestPageState createState() => _userRequestPageState();
}
class _userRequestPageState extends State<userRequestPage> {
  @override
  Widget build(BuildContext context) {
    Widget scaffoldBodyBuilder(BuildContext context, bool flag) {
      if (flag == true) {
        return Column(
          children: <Widget>[
            Padding(
                padding:EdgeInsets.all(120.0),
              child: Text("Nothing here!",
                textAlign: TextAlign.center,
                style:new TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ),

          ],
        );
      }
    }
    return Scaffold(
        appBar: new AppBar(
          title: new Text("Request"),
          backgroundColor: Colors.blueAccent,
        ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add), onPressed: () {},
        shape: _DiamondBorder(),),
      bottomNavigationBar: BottomAppBar(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //IconButton(icon: Icon(Icons.menu), onPressed: () {},),
            IconButton(icon: Icon(Icons.help), onPressed: () {
              showDialog(context: context,builder: (BuildContext context){
                return AlertDialog(
                    title:Text("Hint:"),
                    content:Text("  You can post your requests like modify item's Info or merge a custom item to the menu,the request will handled by admin and you can check status here."),
                    actions:[FlatButton(child: Text("Understood"),onPressed:(){Navigator.pop(context);},)]
                );
              });
            },),
          ],
        ),
      ),
    body:scaffoldBodyBuilder(context,true),
    );
  }
}
class _DiamondBorder extends ShapeBorder {
  const _DiamondBorder();

  @override
  EdgeInsetsGeometry get dimensions {
    return const EdgeInsets.only();
  }

  @override
  Path getInnerPath(Rect rect, { TextDirection textDirection }) {
    return getOuterPath(rect, textDirection: textDirection);
  }

  @override
  Path getOuterPath(Rect rect, { TextDirection textDirection }) {
    return Path()
      ..moveTo(rect.left + rect.width / 2.0, rect.top)
      ..lineTo(rect.right, rect.top + rect.height / 2.0)..lineTo(
          rect.left + rect.width / 2.0, rect.bottom)..lineTo(
          rect.left, rect.top + rect.height / 2.0)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, { TextDirection textDirection }) {}

  @override
  ShapeBorder scale(double t) {
    return null;
  }
}