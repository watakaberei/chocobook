class Recipe < ApplicationRecord
  has_one_attached :image
  
  #アソシエーションの設定
  belongs_to :customer
  
  has_many :recipe_categories, dependent: :destroy
  has_many :categories, through: :recipe_categories, dependent: :destroy
  has_many :recipe_bookmarks, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  
  #バリデーションの設定
  validates :name, presence: true
  validates :introduction, presence: true
  validates :cooktime, presence: true
  validates :image, presence: true
  validates :material, presence: true
  validates :procedure, presence: true


 def self.search(search_word) #①
  Recipe.where(["name LIKE(?) OR introduction LIKE(?) OR procedure LIKE(?)", #②
                 "%#{search_word}%", "%#{search_word}%", "%#{search_word}%"])
 end

 def recipe_bookmarked_by?(customer)
   recipe_bookmarks.exists?(customer_id: customer.id)
 end
end
