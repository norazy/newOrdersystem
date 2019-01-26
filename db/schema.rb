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

ActiveRecord::Schema.define(version: 2019_01_26_042958) do

  create_table "menus", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "category"
    t.text "name"
    t.text "detail"
    t.integer "price"
    t.text "image"
    t.integer "option1"
    t.integer "option2"
    t.integer "option3"
    t.text "name_zh"
    t.text "name_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "optiontables", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "name_opt"
    t.integer "price_opt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orderlists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "menu_id"
    t.integer "price"
    t.integer "number"
    t.integer "state"
    t.integer "option_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
