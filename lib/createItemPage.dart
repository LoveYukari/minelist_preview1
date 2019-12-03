import 'package:flutter/cupertino.dart';
import 'dataJson.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'networkUtil.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
class createItemPage extends StatefulWidget
{
  createItemPage({Key key,this.title}):super(key:key);
  final String title;
  @override
  _createItemPageState createState()=>_createItemPageState();
}
class _createItemPageState extends State<createItemPage>
{
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    json_itemInfo item;
    String itemName;
    String itemCategory;
    String commentInfo;
    String pics;
    String modName;
    String showPics="";
    return Scaffold(
      drawerDragStartBehavior: DragStartBehavior.down,
      appBar: AppBar(
        title:const Text('Create New Item:'),
        backgroundColor: Colors.deepOrange,
      ),
      body:SafeArea(
        top:false,
        bottom:false,
        child:Form(
          child:Scrollbar(
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              padding:const EdgeInsets.symmetric(horizontal: 16.0),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24.0),
                  TextFormField(textCapitalization: TextCapitalization.words,
                    controller: myController1,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.add_box),
                      hintText: "What's this item's name?",
                      labelText: 'Name',
                    ),
                    onSaved: (String value){itemName=value;},
                  ),
                  SizedBox(height: 20,),
                  TextFormField(textCapitalization: TextCapitalization.words,
                    controller: myController2,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.add_box),
                      hintText: "Blocks/Food/Miscs/Weapons/Redstones/Enchantments",
                      labelText: 'Category',
                    ),
                    onSaved: (String value){itemCategory=value;},
                  ),
                  SizedBox(height:30),
                  TextFormField(textCapitalization: TextCapitalization.words,
                    controller: myController3,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      filled: true,
                      icon: Icon(Icons.add_box),
                      hintText: "Default:Minecraft",
                      labelText: 'ModName',
                    ),
                    onSaved: (String value){modName=value;},
                  ),
                  SizedBox(height:30),
                  TextFormField(textCapitalization: TextCapitalization.words,
                    controller: myController4,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "What's this item's about?",
                      labelText: 'Comments',
                    ),
                    onSaved: (String value){commentInfo=value;},
                    maxLines: 6,
                  ),
                  SizedBox(height:24),
                  Container(
                    child: Row(
                      children: <Widget>[
                        RaisedButton(
                          onPressed: ()async
                          {
                            var image;
                            try {
                                  image = await ImagePicker.pickImage(source: ImageSource.gallery);
                                  if(image!=null)print("image imported");
                            }
                            catch(error)
                            {
                              print(error.toString());
                              showPics=error.toString();
                            }
                            if(image!=null) {
                              List<int> imgbytes = image.readAsBytesSync();
                              pics = base64.encode(imgbytes);
                              if (pics != null) {
                                showPics = "Selected Pics";
                              } else {
                                showPics = "";
                                print(0);
                              }
                            }
                          },
                          child:new Text("Choose Image",style: new TextStyle(fontSize: 12,color: Colors.white)),
                          color:Colors.blue,
                        ),
                        SizedBox(width:20),
                        new Text(showPics)
                      ],
                    ),
                  ),
                  SizedBox(height:24),
                  RaisedButton(
                    onPressed: ()async
                      {
                        json_itemInfo item = new json_itemInfo(
                            itemID:"",
                            itemName:myController1.text,
                            itemCategory: myController2.text,
                            commentInfo: myController3.text,
                            base64encTexture: pics,
                            createTime: "",
                            lastUpdateTime: "",
                            modName: myController4.text
                        );
                        if(item.itemName==""||item.itemCategory==""||item.modName==""){
                        showDialog(context: context,builder: (BuildContext context){
                          return AlertDialog(
                            title:Text("Failed to created"),
                            content:Text("please check the info you've input"),
                            actions:[FlatButton(child: Text("OK"),onPressed:(){Navigator.pop(context);}),]
                          );
                        });}else
                          {
                            var resp = await NetworkUtil.createItem(item);
                            if(resp=="success")
                              {
                                showDialog(context: context,builder: (BuildContext context){
                                  return AlertDialog(
                                      title:Text("Success"),
                                      content:Text("Response:ok"),
                                      actions:[FlatButton(child: Text("OK"),onPressed:(){Navigator.pop(context);Navigator.pop(context);}),]
                                  );
                                });
                              }else
                                {
                                  showDialog(context: context,builder: (BuildContext context){
                                    return AlertDialog(
                                        title:Text("Failed"),
                                        content:Text("Oops,something went wrong!"),
                                        actions:[FlatButton(child: Text("OK"),onPressed:(){Navigator.pop(context);}),]
                                    );
                                  });
                                }

                          }
                      },
                    child:new Text("Create!",style:new TextStyle(fontSize: 20,color: Colors.white),),
                    color: Colors.green,

                  )

                ],
              )
            ),
          )
        )
      )
    );

  }
}
