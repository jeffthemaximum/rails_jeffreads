class CreateJoinTableSearchBook < ActiveRecord::Migration
  def change
    create_join_table :Searches, :Books do |t|
      t.index [:search_id, :book_id]
      t.index [:book_id, :search_id]
    end
  end
end
