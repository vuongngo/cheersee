class CreateContactMes < ActiveRecord::Migration
  def change
    create_table :contact_mes do |t|
      t.references :user, index: :true
      t.text :question
      t.text :answer

      t.timestamps
    end
  end
end
