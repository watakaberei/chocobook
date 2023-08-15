class Public::RecipesController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update]

  def index
    @recipes = Recipe.where(is_draft: false).page(params[:page]).per(6).order(created_at: :desc)
    @categories = Category.all
  end

  def rank
    @recipes = Recipe.find(RecipeBookmark.group(:recipe_id).order('count(recipe_id) DESC').limit(5).pluck(:recipe_id))
    @categories = Category.all
  end

  def search
    @recipes = Recipe.all
    @recipes = Recipe.all.search(params[:keyword])
    @categories = Category.all
  end

  def new
    @recipe = Recipe.new
    @recipe.materials.build
    @recipe.procedures.build
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if params[:submit_name] == "下書きに保存"
      @recipe.is_draft = true
    end
    #投稿ボタンを押した場合
    #if params["公開"] == "レシピを公開"
    unless @recipe.draft?
      if @recipe.save
      #if @recipe.materials.each(&:save)
        #byebug
        flash[:notice] = "投稿が完了しました!"
        redirect_to recipe_path(@recipe), notice: "投稿が完了しました！"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end

  #下書きボタンを押した場合
    else
      if @recipe.save
        @recipe.update(is_draft: true)
        redirect_to draft_path, notice: "レシピを下書き保存しました！"
      else
        render :new, alert: "登録できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    end
  end

  def draft
    @recipes = Recipe.where(is_draft: true)
  end

  def history
    @recipes = current_customer.recipes.where(is_draft: false)
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
      if @recipe.valid?(context: :publicize) && @recipe.update(recipe_params.merge(is_draft: false))
        redirect_to recipe_path(@recipe.id), notice: "下書きのレシピを公開しました！"
      else
        @recipe.is_draft = true
        render :edit, alert: "レシピを公開できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # ②公開済みレシピの更新の場合
    elsif params[:update_post]
      if @recipe.update(recipe_params)
        redirect_to recipe_path(@recipe.id), notice: "レシピを更新しました！"
      else
        render :edit, alert: "レシピを更新できませんでした。お手数ですが、入力内容をご確認のうえ再度お試しください"
      end
    # ③下書きレシピの更新（非公開）の場合
    else
      if @recipe.update(recipe_params)
        redirect_to draft_path, notice: "下書きレシピを更新しました！"
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
      :is_draft,
      procedures_attributes: [:id, :body, :_destroy],
      materials_attributes: [:id, :name, :amount, :_destroy],
      category_ids:[]
    )
  end

  def is_matching_login_customer
    recipe = Recipe.find(params[:id])
    if customer_signed_in?
      unless recipe.customer_id == current_customer.id
      redirect_to root_path
      end
    end
  end
end
