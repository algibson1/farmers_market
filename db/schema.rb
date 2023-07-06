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

ActiveRecord::Schema[7.0].define(version: 2023_07_06_033501) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "farms", force: :cascade do |t|
    t.string "name"
    t.boolean "pick_your_own"
    t.integer "acres"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.boolean "fruit"
    t.boolean "seeds"
    t.float "cost_per_pound"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "farm_id"
    t.index ["farm_id"], name: "index_products_on_farm_id"
  end

  add_foreign_key "products", "farms", column: "farm_id"
end
