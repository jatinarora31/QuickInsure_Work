# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_18_093348) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "author_name"
    t.integer "birth_year"
    t.datetime "created_at", null: false
    t.string "nationality"
    t.datetime "updated_at", null: false
  end

  create_table "book_authors", force: :cascade do |t|
    t.bigint "author_id", null: false
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_book_authors_on_author_id"
    t.index ["book_id"], name: "index_book_authors_on_book_id"
  end

  create_table "book_issues", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.date "due_date"
    t.date "issue_date"
    t.date "return_date"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["book_id"], name: "index_book_issues_on_book_id"
    t.index ["user_id"], name: "index_book_issues_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer "available_copies"
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.integer "edition"
    t.integer "isbn"
    t.bigint "publisher_id", null: false
    t.string "title"
    t.integer "total_copies"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["publisher_id"], name: "index_books_on_publisher_id"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "publishers", force: :cascade do |t|
    t.integer "address"
    t.datetime "created_at", null: false
    t.string "nationality"
    t.string "publisher_name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.text "address"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "book_authors", "authors"
  add_foreign_key "book_authors", "books"
  add_foreign_key "book_issues", "books"
  add_foreign_key "book_issues", "users"
  add_foreign_key "books", "categories"
  add_foreign_key "books", "publishers"
end
