class CreateUserAddresses < ActiveRecord::Migration
  def change
    create_table :user_addresses do |t|
      t.references :user
      t.string :address

      t.timestamps
    end
  end
end
