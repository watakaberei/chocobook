class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @recipes = Recipe.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end
end
