class CreateBookLists < ActiveRecord::Migration
  def change
    create_table :book_lists do |t|
      t.references :book, index: true, foreign_key: true
      t.references :search, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
