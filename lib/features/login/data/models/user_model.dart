import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String name;
  final String? urlImage;
  final String uid;

  const UserModel({
    required this.email,
    required this.name,
    required this.uid,
    this.urlImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'urlImage': urlImage,
      'uid': uid,
    };
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      urlImage: map['urlImage'] ?? '',
      uid: id,
    );
  }

  @override
  List<Object?> get props => [email, name, urlImage, uid];
}
