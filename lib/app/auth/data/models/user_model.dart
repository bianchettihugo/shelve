import 'package:shelve/app/auth/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String photoUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.photoUrl,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      photoUrl: entity.photoUrl,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      photoUrl: photoUrl,
    );
  }
}