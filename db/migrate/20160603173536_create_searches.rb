class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :username
      t.integer :hits

      t.timestamps null: false
    end
  end
end
