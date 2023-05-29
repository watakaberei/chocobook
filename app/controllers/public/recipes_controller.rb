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
    #投稿ボタンを押した場合
    if params[:recipe]
      @recipe.customer_id = current_customer.id
      if @recipe.save(context: :publicize)
        redirect_to recipe_path(@recipe)
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
  
  #下書きボタンを押した場合
    else
      if @recipe.update(is_draft: true)
        redirect_to customer_path(current_customer), notice: "レシピを下書き保存しました！"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
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
