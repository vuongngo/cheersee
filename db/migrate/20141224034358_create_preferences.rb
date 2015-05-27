class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :user
      t.text :intro, index: true
      t.text :passion, index: true
      t.text :interest, index: true

      t.timestamps
    end
  end
end
