class Ingredient {
  int ingredientId;
  String ingredientName;
  bool isDeleted;

  Ingredient({
    required this.ingredientId,
    required this.ingredientName,
    this.isDeleted = false,
  });
}