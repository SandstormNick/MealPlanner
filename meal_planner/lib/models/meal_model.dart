class Meal {
  int mealId;
  String mealName;
  bool isDeleted;

  Meal({
    required this.mealId,
    required this.mealName,
    this.isDeleted = false,
  });
}