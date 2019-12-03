import 'dart:convert';

import 'package:dio/dio.dart';

import 'dataJson.dart';
import 'package:flutter/widgets.dart';
class NetworkUtil {
  static String ipAddress = "http://47.98.241.121/";

  static getAllUserInfo() async {
    Dio conn = new Dio();
    Response response = await conn.get(ipAddress + "s_userInfo.php");
    var tempStr = response.data.toString();
    var Strs = tempStr.split('^');
    List <json_userInfo>res = new List(Strs.length-1);
    try {
      for (int i = 0; i < Strs.length - 1; i++) {
        json_userInfo t = json_userInfo.fromJson(json.decode(Strs[i]));
        res[i] = t;
      }
      return res;
    } catch (error) {
      return error.toString();
    }
  }

  static getAllItemInfo() async {
    Dio conn = new Dio();
    Response response = await conn.get(ipAddress + "s_itemInfo.php");
    if (response == null) {
      print("in getAllItemInfo,response is null!");
    }
    //print(ipAddress + "s_itemInfo.php");
    var tempStr = response.data.toString();
    var Strs = tempStr.split('^');
    List<json_itemInfo> res = new List(Strs.length - 1);
    try {
      for (int i = 0; i < Strs.length - 1; i++) {
        json_itemInfo t = json_itemInfo.fromJson(json.decode(Strs[i]));

        try {
          res[i] = t;
        } catch (error) {
          print(error.toString());
        }
      }
      return res;
    } catch (error) {
      return error.toString();
    }
  }

  static getItemInfo_byCategory(String category) async {
    Dio conn = new Dio();
    FormData formData =
        new FormData.fromMap({"category": "\"" + category + "\""});
    Response response =
        await conn.post(ipAddress + "s_itemInfo_category.php", data: formData);

    if (response == null) {
      print("in getAllItemInfo,response is null!");
    }
    //print(ipAddress + "s_itemInfo.php");
    var tempStr = response.data.toString();
    var Strs = tempStr.split('^');
    List<json_itemInfo> res = new List(Strs.length - 1);
    try {
      for (int i = 0; i < Strs.length - 1; i++) {
        json_itemInfo t = json_itemInfo.fromJson(json.decode(Strs[i]));

        try {
          res[i] = t;
        } catch (error) {
          print(error.toString());
        }
      }
      return res;
    } catch (error) {
      return error.toString();
    }
  }

  static getAllRequestDetail() async {

    Dio conn = new Dio();
    Response response = await conn.get(ipAddress + "s_requestDetail.php");
    var tempStr = response.data.toString();
    var Strs = tempStr.split('^');
    List <json_requestDetail> res = new List(Strs.length-1);
    try {
      for(int i=0;i<Strs.length-1;i++)
      {
        res[i]= json_requestDetail.fromJson(json.decode(Strs[i]));
      }
      return res;
    } catch (error) {
      return error.toString();
    }
  }

  static getAllRequestInfo() async {

    Dio conn = new Dio();
    Response response = await conn.get(ipAddress + "s_requestInfo.php");
    var tempStr = response.data.toString();
    var Strs = tempStr.split('^');
    List<json_requestInfo>res = new List(Strs.length-1);
    try {
        for(int i=0;i<Strs.length;i++) {
          res[i]=json_requestInfo.fromJson(json.decode(Strs[i]));
      }
      return res;
    } catch (error) {
      return error.toString();
    }
  }

  static getAllLogInfo() async {

    Dio conn = new Dio();
    Response response = await conn.get(ipAddress + "s_logInfo.php");
    var tempStr = response.data.toString();
    var Strs = tempStr.split('^');
    List<json_logInfo> res = new List(Strs.length-1);
      try {
        for(int i=0;i<Strs.length;i++) {
          res[i]=json_logInfo.fromJson(json.decode(Strs[i]));
        }
      return res;
    } catch (error) {
      return error.toString();
    }
  }

  static getAllUserFavorites()async
  {
    Dio conn = new Dio();
    Response response = await conn.get(ipAddress + "s_userFavorites.php");
    var tempStr = response.data.toString();
    var Strs = tempStr.split('^');
    List<json_userFavorites> res = new List(Strs.length-1);
    try {
      for(int i=0;i<Strs.length;i++) {
        res[i]=json_userFavorites.fromJson(json.decode(Strs[i]));
      }
      return res;
    } catch (error) {
      return error.toString();
    }
  }
  static getUserFavorites(json_userInfo user)async
  {
    Dio conn = new Dio();
    FormData formData =
    new FormData.fromMap(
        {'userID':user.userID}
    );
    Response response = await conn.post(ipAddress + "s_userFavorites_userID.php",data:formData);
    var tempStr = response.data.toString();
    var Strs = tempStr.split('^');
    List<json_itemInfo> res = new List(Strs.length - 1);
    try {
      for (int i = 0; i < Strs.length - 1; i++) {
        json_itemInfo t = json_itemInfo.fromJson(json.decode(Strs[i]));
        try {
          res[i] = t;
        } catch (error) {
          print(error.toString());
        }
      }
      return res;
    } catch (error) {
      return error.toString();
    }
  }
  static createItem (json_itemInfo item)async
  {
    Dio conn = new Dio();
    FormData formData =
    new FormData.fromMap(
      { 'itemName':item.itemName,
        'itemCategory':item.itemCategory,
        'commentInfo':item.commentInfo,
        'texture':item.base64encTexture,
        'modName':item.modName}
    );
    Response response = await conn.post(ipAddress + "c_itemInfo.php", data: formData);
    return(response.data.toString());

  }
  static updateItem (json_itemInfo item)async
  {
    Dio conn = new Dio();
    FormData formData =
    new FormData.fromMap(
        {
          'itemID':item.itemID,
          'itemName':item.itemName,
          'itemCategory':item.itemCategory,
          'commentInfo':item.commentInfo,
          'texture':item.base64encTexture,
          'modName':item.modName}
    );
    Response response = await conn.post(ipAddress + "u_itemInfo.php", data: formData);
    return(response.data.toString());
  }
  static updateUser_user(json_userInfo user)
  {
  }
  static deleteItem (json_itemInfo item)async
  {
    Dio conn = new Dio();
    FormData formData =
    new FormData.fromMap(
        {
          'itemID':item.itemID,}
    );
    Response response = await conn.post(ipAddress + "d_itemInfo.php", data: formData);
    print(item.itemID);
    return(response.data.toString());
  }
  static register(json_userInfo user) async
  {
    Dio conn = new Dio();
    FormData formData =
    new FormData.fromMap(
        { 'userName':user.userName,
          'userID':user.userID,
          'mobile':user.mobile,
          'gender':user.gender,
          'mailAddress':user.mailAddress,
          'passwd':user.passwd,
          'createTime':'',
          'lastUpdateTime':'',
          'userAuthority':''}
    );
    Response response = await conn.post(ipAddress + "register.php", data: formData);
    return(response.data.toString());
  }
  static login (String mailAddress,String passwd)async
  {
    Dio conn = new Dio();
    FormData formData =
    new FormData.fromMap(
        {
          'mailAddress':'\"'+mailAddress+'\"',
          'passwd':passwd,
        }
    );
    Response response = await conn.post(ipAddress + "login.php", data: formData);
    var tempStr = response.data.toString();
    print(tempStr);
    try {
      if(tempStr!="false"){
      var res =json_userInfo.fromJson(json.decode(tempStr));
      return res;}
      else {
        return tempStr;
      }
    } catch (error) {
      return error.toString();
    }
  }

  static userAddfavorites(json_itemInfo item,json_userInfo user)async
  {
    Dio conn = new Dio();
    FormData formData =
    new FormData.fromMap(
        {
          'itemID':item.itemID,
          'userID':user.userID,
        }
    );
    Response response = await conn.post(ipAddress + "add_userFavorites.php", data: formData);


  }

}
