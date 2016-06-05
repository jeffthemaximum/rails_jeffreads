class AddIndexToSearches < ActiveRecord::Migration
  def change
    # add_column :searches, :username, :string
    add_index :searches, :username, unique: true
  end
end
