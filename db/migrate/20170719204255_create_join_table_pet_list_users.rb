class CreateJoinTablePetListUsers < ActiveRecord::Migration[5.0]
  def change
    create_join_table :pet_lists, :users do |t|
      t.index [:pet_list_id, :user_id]
      # t.index [:user_id, :pet_list_id]
    end
  end
end
