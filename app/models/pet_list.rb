class PetList < ApplicationRecord
  # has_many :users, :through => :user_group # QUESTION overkill?
  belongs_to :user_group
  has_many :pets
end
