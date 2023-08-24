require 'rails_helper'

  describe "投稿画面(new_recipe_path)のテスト" do
    before do
      visit new_recipe_path
    end
    context '表示の確認' do
      it 'new_recipe_pathが"/recipes/new"であるか' do
        expect(current_path).to eq('/recipes/new')
      end
      it 'レシピを公開ボタンが表示されているか' do
        expect(page).to have_button 'レシピを公開'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        click_button '投稿'
        expect(page).to have_current_path recipe_path(Recipe.last)
      end
    end
  end