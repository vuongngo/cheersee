class RemoveIntroFromProfile < ActiveRecord::Migration
  def up
    remove_column :profiles, :intro
  end
end
