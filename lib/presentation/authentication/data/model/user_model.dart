import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String? name;
  final String email;
  final String? password;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  UserModel({
    this.uid,
    this.name,
    required this.email,
    this.password,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) : createdAt = createdAt ?? Timestamp.now(),
        updatedAt = updatedAt ?? Timestamp.now();

  factory UserModel.fromFirestore(Map<String, dynamic> data) {

    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'] ?? '',
      createdAt: data['createdAt'] == null ? Timestamp.now() : Timestamp.fromMicrosecondsSinceEpoch(data['createdAt']),
      updatedAt: data['updatedAt'] == null ? Timestamp.now() : Timestamp.fromMicrosecondsSinceEpoch(data['updatedAt']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': createdAt.microsecondsSinceEpoch,
      'updatedAt': updatedAt.microsecondsSinceEpoch,
    };
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? password,
    Timestamp? createdAt,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      createdAt: createdAt ?? this.createdAt,
    );
  }

}
