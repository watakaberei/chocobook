class Public::RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    recipe = Recipe.new(recipe_params)
    recipe.save
    redirect_to '/recipes'
  end

  def show
  end

  private
  # ストロングパラメータ
  def recipe_params
    params.require(:recipe).permit(:customer_id, :category_id, :name, :introduction, :cooktime, :image, :material, :quantity, :procedure)
  end
end
