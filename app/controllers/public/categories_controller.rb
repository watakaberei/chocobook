class Public::CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @categories = Category.all
    @recipes = @category.recipes.page(params[:page]).per(6)
  end

   private
  # ストロングパラメータ
  def category_params
    params.require(:category).permit(:name)
  end
end

