class Admin::RecipeCommentsController < ApplicationController

  def index
    @recipe_comments = RecipeComment.all
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end

end
