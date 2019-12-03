import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minelist_preview1/main.dart';
import 'registerPage.dart';
import 'dataJson.dart';
import 'networkUtil.dart';
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final _mailAddress = TextEditingController();
  final _passwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final json_userInfo user = new json_userInfo(userName:"flw",
      userID: "146007ef04704b4ab3d471042407ec92",
    mobile: "13701852470",
    gender:"1",
    mailAddress: "ryo@mail.com",
    passwd:"abcdeffg1234567",
    createTime:'2019-11-26',
    lastUpdateTime: '2019-11-26',
    userAuthority: '3');
    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: _mailAddress,
      decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
          fillColor: Colors.white70,
          labelText: "MailAddress",
        focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color:Colors.deepOrange,
                width:4,
        )
        )
      )
    );
    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: _passwd,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          contentPadding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
          labelText: "Password",
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color:Colors.deepOrange,
                width:4,
              )
          )
      )
    );
    final LoginButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10),
      color: Colors.brown,
      child: MaterialButton(
        minWidth: 30,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        splashColor: Colors.white70,
        onPressed: () async{
          var resp = await NetworkUtil.login(_mailAddress.text, _passwd.text);
          if(resp!="false")
            {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new MyHomePage(title: "MineList",userInfo: resp,)));
            }
          else{
            showDialog(context: context,builder: (BuildContext context){
              return AlertDialog(
                  title:Text("Failed to Login"),
                  content:Text("Wrong MailAddress or password"),
                  actions:[FlatButton(child: Text("OK"),onPressed:(){Navigator.pop(context);}),]
              );
            });
          }
        },
        child: Text("登录",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold))
        ,
      ),
    );
    final RegistButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10),
      color: Colors.brown,
      child: MaterialButton(
        minWidth: 30,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        splashColor: Colors.white70,
        onPressed: () {Navigator.push(context,new MaterialPageRoute(builder: (context)=>new registerPage(title:"Register")));},
        child: Text("注册",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    final VisitorButton = Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(10),
      color: Colors.brown,
      child: MaterialButton(
        minWidth: 30,
        padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        splashColor: Colors.white70,
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => new MyHomePage(title: "MineList",userInfo: user,)));
        },
        child: Text("游客",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back2.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    SizedBox(
                      height: 250,
                      child: Image.asset(
                        "assets/images/login2.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 40.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(height: 40.0),
                    new Container(
                        child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        LoginButton,
                        RegistButton,
                        VisitorButton,
                      ],
                    ))
                  ],
                ))),
      ),
    );
  }
}

void _onVisitorPressed() {}
