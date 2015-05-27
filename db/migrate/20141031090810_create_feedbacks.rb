class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :reference, index: true
      t.integer :time_management_id
      t.integer :rate
      t.integer :friendly
      t.integer :fun
      t.integer :confidence
      t.integer :curiosity
      t.text :comment

      t.timestamps
    end
  end
end
