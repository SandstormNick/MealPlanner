class ShoppingList {
  int? shoppingListItemId;

  int? mealId;
  String mealName;

  int? ingredientId;
  String ingredientName;  

  ShoppingList({
    this.shoppingListItemId,
    this.mealId,
    this.mealName = '',
    this.ingredientId,
    this.ingredientName = '',
  });
}