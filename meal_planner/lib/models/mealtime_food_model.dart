class MealTimeFood {
  int? mealTimeFoodId;

  int dayMealTimeId; //FK

  int? mealId; //FK  --this can be nullable
  String mealName;

  int? ingredientId; //FK  --this can be nullable
  String ingredientName;  

  bool isDeleted;

  MealTimeFood({
    this.mealTimeFoodId,
    required this.dayMealTimeId,
    this.mealId,
    this.mealName = '',
    this.ingredientId,
    this.ingredientName = '',
    this.isDeleted = false
  });
}