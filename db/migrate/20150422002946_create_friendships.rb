class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :friendship_requester_id
      t.integer :friendship_accepter_id
      t.boolean :established, default: false

      t.timestamps null: false
    end

    #may want to update indices to search also by request/accepter_id and established status
    add_index :friendships, :friendship_requester_id
    add_index :friendships, :friendship_accepter_id
    add_index :friendships, :established
  end
end
