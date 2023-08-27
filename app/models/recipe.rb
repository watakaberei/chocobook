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

  has_many :recipe_bookmarked_customers, through: :recipe_bookmarks, source: :customer

  #関連付けしたモデルを一緒にデータ保存できるようにする
  accepts_nested_attributes_for :procedures, allow_destroy: true
  accepts_nested_attributes_for :materials, allow_destroy: true

  validates :name, presence: true
  validates :introduction, presence: true, unless: :is_draft?
  validates :cooktime, presence: true, unless: :is_draft?
  validates :image, presence: true, unless: :is_draft?
  # #バリデーションの設定
  # with_options presence: true, unless: :draft? do
  #   validates :name
  #   validates :introduction
  #   validates :cooktime
  #   validates :image
  #   #validates :material
  #   #validates :procedure
  # end

  # with_options presence: true, if: :draft?, on: :create do
  #   validates :name
  #   #validates :introduction
  #   #validates :cooktime
  #   #validates :image
  # end

  def draft?
    self.is_draft
  end

  def save_without_validation
    materials.each { |material| material.skip_validation = true }
    procedures.each { |procedure| procedure.skip_validation = true }
    save
  end

  #ソート機能におけるスコープの実装
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :recipe_bookmarked, -> {
    joins(:recipe_bookmarks)
      .group('recipes.id')
      .order('COUNT(recipe_bookmarks.id) DESC')
  }
  
  scope :recipe_commented, -> {
    joins(:recipe_comments)
      .group('recipes.id')
      .order('COUNT(recipe_comments.id) DESC')
  }

 def self.search(search_word) #①
  Recipe.where(["name LIKE(?) OR introduction LIKE(?)", #②
                 "%#{search_word}%", "%#{search_word}%"])
 end

 def recipe_bookmarked_by?(customer)
   return false unless customer.present?
   recipe_bookmarks.where(customer_id: customer.id).exists?
 end
end

