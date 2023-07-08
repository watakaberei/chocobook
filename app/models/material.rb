class Material < ApplicationRecord

  belongs_to :recipe
    with_options presence: true do
    validates :name
    validates :amount
  end
end
