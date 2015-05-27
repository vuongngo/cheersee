class CreateTagMaps < ActiveRecord::Migration
  def change
    create_table :tag_maps do |t|
      t.references :user
      t.references :tag

      t.timestamps
    end
    add_index :tag_maps, :user_id
    add_index :tag_maps, :tag_id
    add_index :tag_maps, [:user_id, :tag_id], unique: true
  end
end
