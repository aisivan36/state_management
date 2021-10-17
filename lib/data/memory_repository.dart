import 'dart:core';
import 'package:flutter/foundation.dart';

import 'repository.dart';
import 'models/models.dart';

class MemoryRepository extends Repository with ChangeNotifier {
  final List<Recipe> _currentRecipes = <Recipe>[];

  final List<Ingredient> _currentIngredients = <Ingredient>[];

  @override
  List<Recipe> findAllRecipes() {
    return _currentRecipes;
  }

  @override
  Recipe findRecipeById(int id) {
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<Ingredient> findAllIngredients() {
    return _currentIngredients;
  }

  @override
  List<Ingredient> findRecipeIngredients(int recipeId) {
    final recipe =
        _currentRecipes.firstWhere((recipe) => recipe.id == recipeId);

    final recipeIngredients = _currentIngredients
        .where((ingredient) => ingredient.recipeId == recipe.id)
        .toList();

    return recipeIngredients;
  }

  @override
  int insertRecipe(Recipe recipe) {
    // add the recipe to our list
    _currentRecipes.add(recipe);
    // call the method to add all the recipe's ingredients
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }

    /// notifies listeners of the changes
    notifyListeners();

// Return ID of the new recipe. Since we don't need it, it will always return 0
    return 0;
  }

  @override
  List<int> insertIngredients(List<Ingredient> ingredients) {
    if (ingredients.length != 0) {
      _currentIngredients.addAll(ingredients);

      /// notifies listeners of the changes
      notifyListeners();
    }
    return <int>[];
  }

  @override
  void deleteRecipe(Recipe recipe) {
    //removes the recipe from your list
    _currentRecipes.remove(recipe);
    // delete all the ingredients fo the recipe
    if (recipe.id != null) {
      deleteRecipeIngredients(recipe.id!);
    }
    // notifies all the listeners from your list
    notifyListeners();
  }

  @override
  void deleteIngredient(Ingredient ingredient) {
    // removes the ingredients from your list
    _currentIngredients.remove(ingredient);
  }

  @override
  void deleteIngredients(List<Ingredient> ingredients) {
    // removes all the ingredients that are in the passed-in list
    _currentIngredients
        .removeWhere((ingredient) => ingredients.contains(ingredient));
    notifyListeners();
  }

  @override
  void deleteRecipeIngredients(int recipeId) {
    // go through all ingredients and look for ingredients
    //that have the given recipe ID then remove them
    _currentIngredients
        .removeWhere((ingredient) => ingredient.recipeId == recipeId);
    notifyListeners();
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {
    // TODO: implement close
  }
}
