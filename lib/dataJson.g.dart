// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dataJson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

json_itemInfo _$json_itemInfoFromJson(Map<String, dynamic> json) {
  return json_itemInfo(
      itemID: json['itemID'] as String,
      itemName: json['itemName'] as String,
      itemCategory: json['itemCategory'] as String,
      commentInfo: json['commentInfo'] as String,
      base64encTexture: json['base64encTexture'] as String,
      modName: json['modName'] as String,
      createTime: json['createTime'] as String,
      lastUpdateTime: json['lastUpdateTime'] as String);
}

Map<String, dynamic> _$json_itemInfoToJson(json_itemInfo instance) =>
    <String, dynamic>{
      'itemID': instance.itemID,
      'itemName': instance.itemName,
      'itemCategory': instance.itemCategory,
      'commentInfo': instance.commentInfo,
      'base64encTexture': instance.base64encTexture,
      'modName': instance.modName,
      'createTime': instance.createTime,
      'lastUpdateTime': instance.lastUpdateTime
    };

json_userInfo _$json_userInfoFromJson(Map<String, dynamic> json) {
  return json_userInfo(
      userName: json['userName'] as String,
      userID: json['userID'] as String,
      mobile: json['mobile'] as String,
      gender: json['gender'] as String,
      mailAddress: json['mailAddress'] as String,
      passwd: json['passwd'] as String,
      createTime: json['createTime'] as String,
      lastUpdateTime: json['lastUpdateTime'] as String,
      userAuthority: json['userAuthority'] as String);
}

Map<String, dynamic> _$json_userInfoToJson(json_userInfo instance) =>
    <String, dynamic>{
      'userName': instance.userName,
      'userID': instance.userID,
      'mobile': instance.mobile,
      'gender': instance.gender,
      'mailAddress': instance.mailAddress,
      'passwd': instance.passwd,
      'createTime': instance.createTime,
      'lastUpdateTime': instance.lastUpdateTime,
      'userAuthority': instance.userAuthority
    };

json_requestDetail _$json_requestDetailFromJson(Map<String, dynamic> json) {
  return json_requestDetail(
      requestID: json['requestID'] as String,
      userID: json['userID'] as String,
      createTime: json['createTime'] as String,
      lastUpdateTime: json['lastUpdateTime'] as String);
}

Map<String, dynamic> _$json_requestDetailToJson(json_requestDetail instance) =>
    <String, dynamic>{
      'requestID': instance.requestID,
      'userID': instance.userID,
      'createTime': instance.createTime,
      'lastUpdateTime': instance.lastUpdateTime
    };

json_requestInfo _$json_requestInfoFromJson(Map<String, dynamic> json) {
  return json_requestInfo(
      requestID: json['requestID'] as String,
      itemID: json['itemID'] as String,
      createTime: json['createTime'] as String,
      lastUpdateTime: json['lastUpdateTime'] as String,
      reasonType: json['reasonType'] as String,
      state: json['state'] as String,
      subInfo: json['subInfo'] as String);
}

Map<String, dynamic> _$json_requestInfoToJson(json_requestInfo instance) =>
    <String, dynamic>{
      'requestID': instance.requestID,
      'itemID': instance.itemID,
      'createTime': instance.createTime,
      'lastUpdateTime': instance.lastUpdateTime,
      'reasonType': instance.reasonType,
      'state': instance.state,
      'subInfo': instance.subInfo
    };

json_logInfo _$json_logInfoFromJson(Map<String, dynamic> json) {
  return json_logInfo(
      loginRecord: json['loginRecord'] as String,
      userID: json['userID'] as String,
      createTime: json['createTime'] as String,
      lastUpdateTime: json['lastUpdateTime'] as String,
      loginStatus: json['loginStatus'] as String);
}

Map<String, dynamic> _$json_logInfoToJson(json_logInfo instance) =>
    <String, dynamic>{
      'loginRecord': instance.loginRecord,
      'userID': instance.userID,
      'createTime': instance.createTime,
      'lastUpdateTime': instance.lastUpdateTime,
      'loginStatus': instance.loginStatus
    };

json_userFavorites _$json_userFavoritesFromJson(Map<String, dynamic> json) {
  return json_userFavorites(
      favID: json['favID'] as String,
      userID: json['userID'] as String,
      createTime: json['createTime'] as String,
      lastUpdateTime: json['lastUpdateTime'] as String,
      itemID: json['itemID'] as String);
}

Map<String, dynamic> _$json_userFavoritesToJson(json_userFavorites instance) =>
    <String, dynamic>{
      'favID': instance.favID,
      'userID': instance.userID,
      'createTime': instance.createTime,
      'lastUpdateTime': instance.lastUpdateTime,
      'itemID': instance.itemID
    };
