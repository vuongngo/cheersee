class CreateWhoHangouts < ActiveRecord::Migration
  def change
    create_table :who_hangouts do |t|
      t.references :hangout, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
