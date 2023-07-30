class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :recipes, dependent: :destroy
  has_many :recipe_bookmarks, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :user_name, presence: true

  def self.guest
    find_or_create_by!(email: "guest@email.com") do |customer|
      customer.last_name = "ゲスト"
      customer.first_name = "ユーザー"
      customer.last_name_kana = "ゲスト"
      customer.first_name_kana = "ユーザー"
      customer.user_name = "ゲスト"
      customer.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
      # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
    end
  end

end
