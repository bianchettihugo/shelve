import '../../domain/entities/category_entity.dart';

class CategoryModel {
  final String name;
  final String icon;
  final bool active;
  final int order;

  CategoryModel({
    required this.name,
    required this.icon,
    required this.order,
    this.active = true,
  });

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
      name: entity.name,
      icon: entity.icon,
      active: entity.active,
      order: entity.order,
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      name: name,
      icon: icon,
      active: active,
      order: order,
    );
  }

  CategoryModel copyWith({
    String? name,
    String? icon,
    bool? active,
    int? order,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      active: active ?? this.active,
      order: order ?? this.order,
    );
  }
}
