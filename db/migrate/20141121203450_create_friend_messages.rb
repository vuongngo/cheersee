class CreateFriendMessages < ActiveRecord::Migration
  def change
    create_table :friend_messages do |t|
      t.references :friendship, index: true
      t.references :user, index: true
      t.text :content

      t.timestamps
    end
  end
end
