class Public::RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    @recipe.save
    redirect_to recipe_path(@recipe)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private
  # ストロングパラメータ
  def recipe_params
    params.require(:recipe).permit(:customer_id, :category_id, :name, :introduction, :cooktime, :image, :material, :quantity, :procedure)
  end
end
