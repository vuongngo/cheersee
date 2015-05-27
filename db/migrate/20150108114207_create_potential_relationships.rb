class CreatePotentialRelationships < ActiveRecord::Migration
  def change
    create_table :potential_relationships do |t|
      t.integer :user_id, index: true
      t.integer :stranger_id, index: true
      t.integer :like_no
      t.integer :comment_no
      t.integer :joint_no

      t.timestamps
    end
  end
end
