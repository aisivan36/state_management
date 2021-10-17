import 'models/models.dart';

abstract class Repository {
  /// Return all recipes in the repository
  List<Recipe> findAllRecipes();

  /// Find specific recipe by its ID
  Recipe findRecipeById(int id);

  /// Return all ingredients
  List<Ingredient> findAllIngredients();

  /// Find all ingredients for the given reciep ID
  List<Ingredient> findRecipeIngredients(int recipeId);

  /// Insert a new recipe
  int insertRecipe(Recipe recipe);

  /// Add all the given ingredients
  List<int> insertIngredients(List<Ingredient> ingredients);

  /// Delete the given recipe
  void deleteRecipe(Recipe recipe);

  /// Delete the given ingredient
  void deleteIngredient(Ingredient ingredient);

  /// delete all the given ingredient
  void deleteIngredients(List<Ingredient> ingredients);

  /// Delete all the given ingredients for the given recipe ID
  void deleteRecipeIngredients(int recipeID);

  /// Allow the repository to initialize
  ///  Databases might need to do some startup work
  Future init();

  /// Close the repository
  void close();
}
