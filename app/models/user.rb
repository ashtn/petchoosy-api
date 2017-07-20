class User < ApplicationRecord
  has_and_belongs_to_many :pet_lists
  # has_many :pets
end
