class PetList < ApplicationRecord
  # has_many :users, :through => :pets
  has_and_belongs_to_many :users
  has_many :pets
end
