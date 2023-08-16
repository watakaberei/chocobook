class Admin::RecipesController < ApplicationController

  def index
    @recipes = Recipe.where(is_draft: false).page(params[:page]).per(10)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update(recipe_params)
    redirect_to admin_recipe_path(@recipe.id)
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to admin_recipes_path
  end

  private
  # ストロングパラメータ
  def recipe_params
    params.require(:recipe).permit(
      :customer_id,
      :name,
      :image,
      :introduction,
      :cooktime,
      :is_draft,
      procedures_attributes: [:id, :body, :_destroy],
      materials_attributes: [:id, :name, :amount, :_destroy],
      category_ids:[]
    )
  end
end
