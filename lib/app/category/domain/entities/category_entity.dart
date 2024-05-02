class CategoryEntity {
  final String name;
  final String icon;
  final int order;
  final bool active;

  CategoryEntity({
    required this.name,
    required this.icon,
    required this.order,
    this.active = true,
  });
}
