import 'package:flutter/cupertino.dart';
import 'package:minelist_preview1/main.dart';
import 'dataJson.dart';
import 'dart:io';
import 'dart:async';
import 'loginPage.dart';
import 'package:flutter/material.dart';
import 'networkUtil.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'dart:convert';
import 'package:uuid/uuid.dart';
class registerPage extends StatefulWidget
{
  registerPage({Key key,this.title}):super(key:key);
  final String title;
  @override
  _registerPageState createState()=>_registerPageState();
}
class _registerPageState extends State<registerPage>
{
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerDragStartBehavior: DragStartBehavior.down,
        appBar: AppBar(
          title:const Text('Register'),
          backgroundColor: Colors.deepPurpleAccent,
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
                              icon: Icon(Icons.mail),
                              hintText: "most SOP3/SMTP is supported...",
                              labelText: 'Mailaddress',
                            ),
                          ),
                          SizedBox(height:10,),
                          TextFormField(textCapitalization: TextCapitalization.words,
                            controller: myController2,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon: Icon(Icons.vpn_key),
                              hintText: "",
                              labelText: 'Password',
                            ),
                          ),
                          SizedBox(height:10),
                          TextFormField(textCapitalization: TextCapitalization.words,
                            controller: myController3,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon: Icon(Icons.phone_iphone),
                              hintText: "Hey,pinyin,no chinese!",
                              labelText: 'Name',
                            ),
                          ),
                          SizedBox(height:10),
                          TextFormField(textCapitalization: TextCapitalization.words,
                            controller: myController4,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              filled: true,
                              icon: Icon(Icons.phone_iphone),
                              hintText: "China only!",
                              labelText: 'Mobile',
                            ),
                            maxLength: 11,
                          ),
                          SizedBox(height:10),
                          /*Row(
                            children: <Widget>[
                              SizedBox(width: 30,),
                              Text("Gender:",style: new TextStyle(fontSize: 20),),
                              SizedBox(width: 40,),
                              Text("Male",style: new TextStyle(fontSize: 18,color:Colors.blue),),
                              Checkbox(value:_gender,onChanged:(value){setState(() {
                                _gender=true;
                              });},),
                              SizedBox(width:30),
                              Text("Female",style: new TextStyle(fontSize: 18,color:Colors.pink),),
                              Checkbox(value:_gender,onChanged:(value){setState(() {
                                _gender=false;
                              });},),
                            ],
                          ),*/
                            TextFormField(textCapitalization: TextCapitalization.words,
                              controller: myController5,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                filled: true,
                                icon: Icon(Icons.group),
                                hintText: "Male:1/Female:0",
                                labelText: 'Gender',
                              ),
                              maxLength: 1,
                            ),
                          SizedBox(height:24),
                          RaisedButton(
                            onPressed: ()async
                            {
                              var uuid = Uuid();
                              json_userInfo user = new json_userInfo(
                                userID: uuid.v1().replaceAll("-","") ,
                                userName: myController3.text,
                                mobile: myController4.text,
                                gender: myController5.text,
                                mailAddress: myController1.text,
                                passwd: myController2.text,
                                createTime: '',
                                lastUpdateTime: '',
                                userAuthority: " ",
                              );
                              if(user.userName!=""&&user.mailAddress!="")
                                {
                                  var resp = await NetworkUtil.register(user);
                                  print(resp);
                                  if(resp=="success")
                                    {
                                      showDialog(context: context,builder: (BuildContext context){
                                        return AlertDialog(
                                            title:Text("Success"),
                                            content:Text("UserID:"+user.userID),
                                            actions:[FlatButton(child: Text("OK"),onPressed:(){Navigator.push(context,new MaterialPageRoute(builder: (context)=>new LoginPage(title:"")));}),]
                                        );
                                      });
                                    }
                                  else
                                    {
                                      showDialog(context: context,builder: (BuildContext context){
                                        return AlertDialog(
                                            title:Text("Oops!"),
                                            content:Text("Something went wrong"),
                                            actions:[FlatButton(child: Text("OK"),onPressed:(){Navigator.pop(context);}),]
                                        );
                                      });
                                    }
                                }
                              else
                                {
                                  showDialog(context: context,builder: (BuildContext context){
                                    return AlertDialog(
                                        title:Text("Oops!"),
                                        content:Text("Empty username or mailAddress"),
                                        actions:[FlatButton(child: Text("OK"),onPressed:(){Navigator.pop(context);}),]
                                    );
                                  });
                                }

                            },
                            child:new Text("Register",style:new TextStyle(fontSize: 20,color: Colors.white),),
                            color: Colors.purpleAccent,

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
