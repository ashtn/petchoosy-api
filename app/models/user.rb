class User < ApplicationRecord
  has_and_belongs_to_many :user_groups
  has_many :pets
end
