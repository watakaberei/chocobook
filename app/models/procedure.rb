class Procedure < ApplicationRecord

  belongs_to :recipe
   with_options presence: true do
   validates :body
  end
end
