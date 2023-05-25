class Recipe < ApplicationRecord
  has_one_attached :image
  
  belongs_to :customer

 def self.search(search_word) #①
  Recipe.where(["name LIKE(?) OR introduction LIKE(?) OR procedure LIKE(?)", #②
                 "%#{search_word}%", "%#{search_word}%", "%#{search_word}%"])
 end
  
end
