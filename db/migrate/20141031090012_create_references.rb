class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.integer :user_id
      t.integer :receiver_id
      t.integer :hangout_id
      t.boolean :feed, :default => false

      t.timestamps
    end
	add_index :references, :receiver_id
	add_index :references, :user_id
  end
end
