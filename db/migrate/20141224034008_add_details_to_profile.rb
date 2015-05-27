class AddDetailsToProfile < ActiveRecord::Migration
  def change
  	add_column :profiles, :gender, :string
  	add_index :profiles, :gender
    add_column :profiles, :age, :integer
    add_index :profiles, :age
    add_column :profiles, :hometown, :string
    add_index :profiles, :hometown
  end
end
