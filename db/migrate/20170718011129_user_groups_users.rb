class UserGroupsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :user_groups_users, :id => false do |t|
      t.integer :user_group_id
      t.integer :user_id
    end
  end
end
