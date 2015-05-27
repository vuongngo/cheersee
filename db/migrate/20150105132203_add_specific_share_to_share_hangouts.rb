class AddSpecificShareToShareHangouts < ActiveRecord::Migration
  def change
    add_column :share_hangouts, :specific_share, :boolean
  end
end
