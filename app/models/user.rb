class User < ApplicationRecord
  has_many :pets
  # belongs_to :pet_list
  has_and_belongs_to_many :pet_lists
  # has_many :pet_lists, :through => :pets
end
