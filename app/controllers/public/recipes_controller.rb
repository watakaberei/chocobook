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
    #投稿ボタンを押した場合
    if params["公開"]
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
    @recipe = Recipe.find(params[:id])
    # ①下書きレシピの更新（公開）の場合
    if params[:publicize_draft]
      # レシピ公開時にバリデーションを実施
      # updateメソッドにはcontextが使用できないため、公開処理にはattributesとsaveメソッドを使用する
      @recipe.attributes = recipe_params.merge(is_draft: false)
      if @recipe.save(context: :publicize)
        redirect_to recipe_path(@recipe.id), notice: "下書きのレシピを公開しました！"
      else
        @recipe.is_draft = true
        render :edit, alert: "レシピを公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # ②公開済みレシピの更新の場合
    elsif params[:update_post]
      @recipe.attributes = recipe_params
      if @recipe.save(context: :publicize)
        redirect_to recipe_path(@recipe.id), notice: "レシピを更新しました！"
      else
        render :edit, alert: "レシピを更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # ③下書きレシピの更新（非公開）の場合
    else
      if @recipe.update(recipe_params)
        redirect_to recipe_path(@recipe.id), notice: "下書きレシピを更新しました！"
      else
        render :edit, alert: "更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end

  def destroy
    recipe = Recipe.find(params[:id])
    recipe.destroy
    redirect_to root_path
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

