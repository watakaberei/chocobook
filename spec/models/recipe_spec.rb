# spec/models/recipe_spec.rb

require 'rails_helper'

RSpec.describe 'Recipeモデルのテスト', type: :model do
  describe '実際に保存してみる' do
    it "有効なレシピの場合は保存されるか" do
      expect(FactoryBot.build(:recipe)).to be_valid
    end
  end
end
