class CreateFriendhashes < ActiveRecord::Migration
  def change
    create_table :friendhashes do |t|
      t.references :user, index: true
      t.text :token, index: true
      t.datetime :expired_at
      t.float :lat
      t.float :lng

      t.timestamps
    end
    add_index :friendhashes, [:user_id, :token], unique: true
  end
end
