class Public::HomesController < ApplicationController

  def top
    @categories = Category.all
    @recipes = params[:name].present? ? Category.find(params[:name]).recipes : Recipe.all
    @recipes_rank = Recipe.find(RecipeBookmark.group(:recipe_id).order('count(recipe_id) DESC').limit(5).pluck(:recipe_id))
    @recipes_new = Recipe.all.order(created_at: :desc) && Recipe.where(is_draft: false)
  end

  def about
  end

end
