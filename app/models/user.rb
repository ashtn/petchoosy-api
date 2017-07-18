class User < ApplicationRecord
  has_and_belongs_to_many :user_groups
  has_many :pet_list_interests
end
