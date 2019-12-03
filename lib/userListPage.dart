import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minelist_preview1/ItemPage.dart';

import 'dataJson.dart';

///this is for main.dart's menu 's item it needs a category list to init;
class userListPage extends StatefulWidget {
  userListPage({Key key, this.searchList}) : super(key: key);
  final List<json_userInfo> searchList;

  @override
  _userListPageState createState() => _userListPageState();
}

class _userListPageState extends State<userListPage> {
  @override
  Widget build(BuildContext context) {
    Widget userListViewItemBuilder(BuildContext context, int count) {
      json_userInfo itemInfo = widget.searchList[count];
      TextStyle textStyle =
      new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0);
      return new ListTile(
          title: Text(widget.searchList[count].userName),
          subtitle: Text(widget.searchList[count].userID),
          leading: Container(
            width: 60,height: 60,child: new Icon(Icons.person),
          ),
            );
    }
    return Scaffold(
        appBar: AppBar(
          title: new Text("Users"),
          backgroundColor: Colors.blueAccent,
        ),
        body: new ListView.builder(
          padding: new EdgeInsets.all(3.0),
          itemExtent: 60.0,
          itemCount: widget.searchList.length,
          itemBuilder: userListViewItemBuilder,
        ));
  }
}
