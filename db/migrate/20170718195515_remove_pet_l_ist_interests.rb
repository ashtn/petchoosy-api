class RemovePetLIstInterests < ActiveRecord::Migration[5.0]

  def down
    drop_table :pet_list_interest
  end

end
