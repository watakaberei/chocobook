class Public::RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def search
    @recipes = Recipe.all
    @recipes = Recipe.all.search(params[:keyword])
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if @recipe.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe_comment = RecipeComment.new
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    recipe = Recipe.find(params[:id])
    recipe.update(recipe_params)
    redirect_to recipe_path(recipe.id)
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to root_path
  end
  
  private
  # ストロングパラメータ
  def recipe_params
    params.require(:recipe).permit(:customer_id, :name, :introduction, :cooktime, :image, :material, :procedure, category_ids:[] )
  end
end
