class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :image_url
      t.string :good_link
      t.integer :num_pages
      t.string :format
      t.string :publisher
      t.integer :publication_day
      t.integer :publication_month
      t.integer :publication_year
      t.integer :average_rating
      t.text :description
      t.text :author_name
      t.text :amazon_link
      t.integer :good_ratings_count
      t.integer :jeff_user_count

      t.timestamps null: false
    end
  end
end
