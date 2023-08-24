require 'rails_helper'

RSpec.describe 'Customerモデルのテスト', type: :model do
  describe '実際に保存してみる' do
    it "有効な会員情報の場合は保存されるか" do
      expect(FactoryBot.build(:customer)).to be_valid
    end
  end
  
  context "空白のバリデーションチェック" do
    it "last_nameが空白の場合バリデーションチェックされ空白のエラーメッセージが返ってくる" do
      customer = Customer.new(last_name: '')
      expect(customer).to be_invalid
      expect(customer.errors[:last_name]).to include("can't be blank")
    end
  end 
end