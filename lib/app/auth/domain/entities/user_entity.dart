class UserEntity {
  final String id;
  final String email;
  final String name;
  final String photoUrl;

  String get firstName => name.split(' ')[0];

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.photoUrl,
  });
}
