class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :age, :integer
    add_column :users, :job, :string
    add_column :users, :quote, :string
  end
end
