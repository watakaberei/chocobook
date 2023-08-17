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
  with_options presence: true, unless: :draft? do
    validates :name
    validates :introduction
    validates :cooktime
    validates :image
    #validates :material
    #validates :procedure
  end

  with_options presence: true, if: :draft?, on: :create do
    validates :name
    validates :introduction
    validates :cooktime
    validates :image
  end

  def draft?
    self.is_draft
  end

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}

 def self.search(search_word) #①
  Recipe.where(["name LIKE(?) OR introduction LIKE(?)", #②
                 "%#{search_word}%", "%#{search_word}%"])
 end


 def recipe_bookmarked_by?(customer)
   return false unless customer.present?
   recipe_bookmarks.where(customer_id: customer.id).exists?
 end
end

