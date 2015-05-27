class CreateHangoutMessages < ActiveRecord::Migration
  def change
    create_table :hangout_messages do |t|
      t.references :hangout, index: true
      t.references :user, index: true
      t.text :content

      t.timestamps
    end
  end
end
