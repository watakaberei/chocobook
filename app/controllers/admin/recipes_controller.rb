class Admin::RecipesController < ApplicationController

  def index
    @recipes = Recipe.where(is_draft: false)
  end

  def show
    @recipe = Recipe.find(params[:id])
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
      :material,
      :procedure,
      :is_draft,
      category_ids:[]
    )
  end
end
