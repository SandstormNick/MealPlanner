class MealTimeFood {
  int mealTimeFoodId;

  int dayMealTimeId; //FK

  int? mealId; //FK  --this can be nullable
  String mealName;

  int? ingredientId; //FK  --this can be nullable
  String ingredientName;  

  bool isDeleted;

  MealTimeFood({
    required this.mealTimeFoodId,
    required this.dayMealTimeId,
    this.mealName = "",
    this.ingredientName = "",
    this.isDeleted = false
  });
}