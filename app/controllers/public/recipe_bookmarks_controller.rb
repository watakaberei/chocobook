class Public::RecipeBookmarksController < ApplicationController

  def create
    recipe = Recipe.find(params[:recipe_id])
    recipe_bookmark = current_customer.recipe_bookmarks.new(recipe_id: recipe.id)
    recipe_bookmark.save
    redirect_to recipe_path(recipe)
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    recipe_bookmark = current_customer.recipe_bookmarks.find_by(recipe_id: recipe.id)
    recipe_bookmark.destroy
    redirect_to recipe_path(recipe)

  end
end
