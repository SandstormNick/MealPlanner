class Meal {
  int? mealId;
  String mealName;
  bool isDeleted;

  Meal({
    this.mealId,
    required this.mealName,
    this.isDeleted = false,
  });
}