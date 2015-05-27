class CreateTimeManagements < ActiveRecord::Migration
  def change
    create_table :time_managements do |t|
      t.text :manage

      t.timestamps
    end
  end
end
