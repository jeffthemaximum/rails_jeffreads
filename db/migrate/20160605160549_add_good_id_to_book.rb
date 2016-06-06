class AddGoodIdToBook < ActiveRecord::Migration
  def change
    add_column :books, :good_id, :integer
  end
end
