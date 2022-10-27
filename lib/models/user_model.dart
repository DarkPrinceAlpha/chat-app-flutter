// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final String phoneNum;
  final bool isOnline;
  final List<String> groupId;
  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.phoneNum,
    required this.isOnline,
    required this.groupId,
  });

  UserModel copyWith({
    String? name,
    String? uid,
    String? profilePic,
    String? phoneNum,
    bool? isOnline,
    List<String>? groupId,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      phoneNum: phoneNum ?? this.phoneNum,
      isOnline: isOnline ?? this.isOnline,
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'phoneNum': phoneNum,
      'isOnline': isOnline,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] as String,
        uid: map['uid'] as String,
        profilePic: map['profilePic'] as String,
        phoneNum: map['phoneNum'] as String,
        isOnline: map['isOnline'] as bool,
        //we are getting list of dynamic and converting it to list of string using
        //map funtion
        // https://app.quicktype.io/
        groupId:
            (map['groupId'] as List).map((group) => group as String).toList());
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, uid: $uid, profilePic: $profilePic, phoneNum: $phoneNum, isOnline: $isOnline, groupId: $groupId)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.uid == uid &&
        other.profilePic == profilePic &&
        other.phoneNum == phoneNum &&
        other.isOnline == isOnline &&
        listEquals(other.groupId, groupId);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uid.hashCode ^
        profilePic.hashCode ^
        phoneNum.hashCode ^
        isOnline.hashCode ^
        groupId.hashCode;
  }
}
