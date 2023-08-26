class Material < ApplicationRecord
  attr_accessor :skip_validation
  belongs_to :recipe

  validates :name, presence:true, unless: :skip_validation
  validates :amount, presence:true, unless: :skip_validation
end
