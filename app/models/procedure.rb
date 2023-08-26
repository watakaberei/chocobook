class Procedure < ApplicationRecord
  attr_accessor :skip_validation
  belongs_to :recipe

  validates :body, presence:true, unless: :skip_validation
end
