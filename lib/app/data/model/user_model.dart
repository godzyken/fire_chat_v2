
import 'package:fire_chat_v2/app/core/helpers/helpers.dart';

class UserModelField {
  static final String updatedAt = 'updatedAt';
  static final String createdAt = 'createAt';
  static final String lastActive = 'lastActive';
}

class UserModel {
  final String? uid;
  final String? email;
  final String? name;
  final String? lastName;
  final String? photoUrl;
  final String? role;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastActive;
  final bool? isOnline;
  final bool? isBanned;
  final bool? isShadowBanned;
  final bool? isStaffUser;

  UserModel({
    required this.uid,
    required this.name,
    required this.photoUrl,
    this.email,
    this.lastName,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.lastActive,
    this.isOnline,
    this.isBanned,
    this.isShadowBanned,
    this.isStaffUser
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    String? createdAt,
    String? updatedAt,
    String? lastActive,
    String? lastName,
    String? isOnline,
    String? isBanned,
    String? isShadowBanned,
    String? isStaffUser,
    String? role,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        photoUrl: photoUrl ?? this.photoUrl,
        updatedAt: updatedAt as DateTime? ?? this.updatedAt,
        createdAt: createdAt as DateTime? ?? this.createdAt,
        lastActive: lastActive as DateTime? ?? this.lastActive,
        isOnline: isOnline as bool? ?? this.isOnline,
        isBanned: isBanned as bool? ?? this.isBanned,
        isShadowBanned: isShadowBanned as bool? ?? this.isShadowBanned,
        role: role ?? this.role,
        isStaffUser: isStaffUser as bool? ?? this.isStaffUser,
      );

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'],
    name: json['name'],
    email: json['email'],
    photoUrl: json['photoUrl'],
    lastName: json['lastName'],
    isOnline: json['isOnline'],
    isBanned: json['isBanned'],
    isShadowBanned: json['isShadowBanned'],
    isStaffUser: json['isStaffUser'],
    role: json['role'],
    createdAt: Utils.toDateTime(json['createdAt']),
    updatedAt: Utils.toDateTime(json['updatedAt']),
    lastActive: Utils.toDateTime(json['lastActive']),
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'email': email,
    'name': name,
    'photoUrl': photoUrl,
    'lastName': lastName,
    'isOnline': isOnline,
    'isBanned': isBanned,
    'isShadowBanned': isShadowBanned,
    'isStaffUser': isStaffUser,
    'role': role,
    'lastActive': Utils.fromDateTimeToJson(lastActive),
    'createdAt': Utils.fromDateTimeToJson(createdAt),
    'updatedAt': Utils.fromDateTimeToJson(updatedAt),
  };

  int get hashCode => uid.hashCode ^ name.hashCode ^ photoUrl.hashCode;

  bool operator ==(other) =>
      other is UserModel &&
          other.name == name &&
          other.photoUrl == photoUrl &&
          other.uid == uid;
}