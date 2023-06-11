class Admin::RecipeCommentsController < ApplicationController

  def index
    @recipe_comments = RecipeComment.all
  end

  def destroy
    comment = RecipeComment.find(params[:id])
    recipe_id = comment.recipe_id # コメントが所属するレシピのIDを取得
    comment.destroy
    redirect_to admin_recipe_path(recipe_id)
  end

  private

  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end

end
