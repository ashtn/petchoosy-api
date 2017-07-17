class User < ApplicationRecord
  has_many :user_groups
  has_many :pet_list_interests
end
