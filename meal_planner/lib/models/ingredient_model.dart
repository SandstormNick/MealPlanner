class Ingredient {
  int? ingredientId;
  String ingredientName;
  bool isDeleted;

  Ingredient({
    this.ingredientId,
    required this.ingredientName,
    this.isDeleted = false,
  });
}