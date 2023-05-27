class Public::CategoriesController < ApplicationController
  
  def show
    @category = Category.find(params[:id])  
  end

   private
  # ストロングパラメータ
  def category_params
    params.require(:category).permit(:name)
  end
end

