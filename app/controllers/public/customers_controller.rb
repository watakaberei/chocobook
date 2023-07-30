class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_my_page_path(current_customer)
    else
      render :edit # or render :edit_customer, depending on your view name
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def recipe_bookmarks
    @customer = Customer.find(params[:id])
    recipe_bookmarks = RecipeBookmark.where(customer_id: @customer.id).pluck(:recipe_id)
    @recipe_bookmark_recipes = Recipe.find(recipe_bookmarks)
  end
  

  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  

  private

  # ストロングパラメータ
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :email, :encrypted_password)
  end
end
