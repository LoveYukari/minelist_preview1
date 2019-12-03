import 'package:json_annotation/json_annotation.dart';

part 'dataJson.g.dart';

@JsonSerializable()
class json_itemInfo {
  @JsonKey()
  final String itemID;
  final String itemName;
  final String itemCategory;
  final String commentInfo;
  final String base64encTexture;
  final String modName;
  final String createTime;
  final String lastUpdateTime;

  @JsonKey(nullable: false)
  json_itemInfo(
      {this.itemID,
      this.itemName,
      this.itemCategory,
      this.commentInfo,
      this.base64encTexture,
      this.modName,
      this.createTime,
      this.lastUpdateTime});

  factory json_itemInfo.fromJson(Map<String, dynamic> json) =>
      _$json_itemInfoFromJson(json);

  Map<String, dynamic> toJson() => _$json_itemInfoToJson(this);
}

@JsonSerializable()
class json_userInfo {
  @JsonKey()
  final String userName;
  final String userID;
  final String mobile;
  final String gender;
  final String mailAddress;
  final String passwd;
  final String createTime;
  final String lastUpdateTime;
  final String userAuthority;

  json_userInfo(
      {this.userName,
      this.userID,
      this.mobile,
      this.gender,
      this.mailAddress,
      this.passwd,
      this.createTime,
      this.lastUpdateTime,
      this.userAuthority});

  factory json_userInfo.fromJson(Map<String, dynamic> json) =>
      _$json_userInfoFromJson(json);

  Map<String, dynamic> toJson() => _$json_userInfoToJson(this);
}

@JsonSerializable()
class json_requestDetail {
  @JsonKey()
  final String requestID;
  final String userID;
  final String createTime;
  final String lastUpdateTime;

  json_requestDetail(
      {this.requestID, this.userID, this.createTime, this.lastUpdateTime});

  factory json_requestDetail.fromJson(Map<String, dynamic> json) =>
      _$json_requestDetailFromJson(json);

  Map<String, dynamic> toJson() => _$json_requestDetailToJson(this);
}

@JsonSerializable()
class json_requestInfo {
  @JsonKey()
  final String requestID;
  final String itemID;
  final String createTime;
  final String lastUpdateTime;
  final String reasonType;
  final String state;
  final String subInfo;

  json_requestInfo(
      {this.requestID,
      this.itemID,
      this.createTime,
      this.lastUpdateTime,
      this.reasonType,
      this.state,
      this.subInfo});

  factory json_requestInfo.fromJson(Map<String, dynamic> json) =>
      _$json_requestInfoFromJson(json);

  Map<String, dynamic> toJson() => _$json_requestInfoToJson(this);
}

@JsonSerializable()
class json_logInfo {
  @JsonKey()
  final String loginRecord;
  final String userID;
  final String createTime;
  final String lastUpdateTime;
  final String loginStatus;

  json_logInfo(
      {this.loginRecord,
      this.userID,
      this.createTime,
      this.lastUpdateTime,
      this.loginStatus});

  factory json_logInfo.fromJson(Map<String, dynamic> json) =>
      _$json_logInfoFromJson(json);

  Map<String, dynamic> toJson() => _$json_logInfoToJson(this);
}

@JsonSerializable()
class json_userFavorites {
  @JsonKey()
  final String favID;
  final String userID;
  final String createTime;
  final String lastUpdateTime;
  final String itemID;

  json_userFavorites(
      {this.favID,
      this.userID,
      this.createTime,
      this.lastUpdateTime,
      this.itemID});

  factory json_userFavorites.fromJson(Map<String, dynamic> json) =>
      _$json_userFavoritesFromJson(json);

  Map<String, dynamic> toJson() => _$json_userFavoritesToJson(this);
}
