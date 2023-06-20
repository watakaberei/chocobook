class Recipe < ApplicationRecord
  has_one_attached :image

  #アソシエーションの設定
  belongs_to :customer

  has_many :recipe_categories, dependent: :destroy
  has_many :categories, through: :recipe_categories, dependent: :destroy
  has_many :recipe_bookmarks, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :procedures, dependent: :destroy
  has_many :materials, dependent: :destroy

  #関連付けしたモデルを一緒にデータ保存できるようにする
  accepts_nested_attributes_for :procedures, allow_destroy: true
  accepts_nested_attributes_for :materials, allow_destroy: true

  #バリデーションの設定
  with_options presence: true, on: :publicize do
  validates :name, presence: true
  validates :introduction, presence: true
  validates :cooktime, presence: true
  validates :image, presence: true
  validates :material, presence: true
  validates :procedure, presence: true
  end

 def self.search(search_word) #①
  Recipe.where(["name LIKE(?) OR introduction LIKE(?)", #②
                 "%#{search_word}%", "%#{search_word}%"])
 end


 def recipe_bookmarked_by?(customer)
   return false unless customer.present?
   recipe_bookmarks.where(customer_id: customer.id).exists?
 end
end

