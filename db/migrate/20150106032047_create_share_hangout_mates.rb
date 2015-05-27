class CreateShareHangoutMates < ActiveRecord::Migration
  def change
    create_table :share_hangout_mates do |t|
      t.references :share_hangout
      t.references :user

      t.timestamps
    end
  end
end
