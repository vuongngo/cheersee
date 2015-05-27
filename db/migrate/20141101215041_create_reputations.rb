class CreateReputations < ActiveRecord::Migration
  def change
    create_table :reputations do |t|
      t.references :user, index: true
      t.float :time_early
      t.float :time_late
      t.float :never_come
      t.float :rate_av
      t.float :friendly_av
      t.float :fun_av
      t.float :confidence_av
      t.float :curiosity_av
      t.integer :number_of_rate

      t.timestamps
    end
  end
end
