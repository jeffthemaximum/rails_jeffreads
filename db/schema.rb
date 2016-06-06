# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160605183839) do

  create_table "book_lists", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "book_lists", ["book_id"], name: "index_book_lists_on_book_id"
  add_index "book_lists", ["search_id"], name: "index_book_lists_on_search_id"

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "image_url"
    t.string   "good_link"
    t.integer  "num_pages"
    t.string   "format"
    t.string   "publisher"
    t.integer  "publication_day"
    t.integer  "publication_month"
    t.integer  "publication_year"
    t.integer  "average_rating"
    t.text     "description"
    t.text     "author_name"
    t.text     "amazon_link"
    t.integer  "good_ratings_count"
    t.integer  "jeff_user_count"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "good_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string   "username"
    t.integer  "hits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "searches", ["username"], name: "index_searches_on_username", unique: true

end
