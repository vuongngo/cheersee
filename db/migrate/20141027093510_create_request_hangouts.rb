class CreateRequestHangouts < ActiveRecord::Migration
  def change
    create_table :request_hangouts do |t|
      t.references :user, index: true
      t.references :share_hangout, index: true
      t.text :mes
      t.boolean :accept, :default => false

      t.timestamps
    end
    add_index :request_hangouts, [:user_id, :share_hangout_id], unique: true
  end
end
