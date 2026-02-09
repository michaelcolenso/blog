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

ActiveRecord::Schema[7.1].define(version: 2026_02_09_062920) do
  create_table "clicks", force: :cascade do |t|
    t.integer "link_id", null: false
    t.integer "page_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.string "referrer"
    t.string "country"
    t.string "city"
    t.datetime "clicked_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clicked_at"], name: "index_clicks_on_clicked_at"
    t.index ["link_id"], name: "index_clicks_on_link_id"
    t.index ["page_id"], name: "index_clicks_on_page_id"
  end

  create_table "links", force: :cascade do |t|
    t.integer "page_id", null: false
    t.string "title"
    t.string "url"
    t.integer "position"
    t.integer "clicks_count"
    t.boolean "visible"
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_links_on_page_id"
    t.index ["position"], name: "index_links_on_position"
  end

  create_table "pages", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "handle"
    t.string "title"
    t.text "description"
    t.string "theme"
    t.string "avatar_url"
    t.boolean "published"
    t.integer "views_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["handle"], name: "index_pages_on_handle", unique: true
    t.index ["user_id"], name: "index_pages_on_user_id"
    t.index ["views_count"], name: "index_pages_on_views_count"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "plan"
    t.string "status"
    t.string "stripe_customer_id"
    t.string "stripe_subscription_id"
    t.datetime "current_period_end"
    t.datetime "trial_ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clicks", "links"
  add_foreign_key "clicks", "pages"
  add_foreign_key "links", "pages"
  add_foreign_key "pages", "users"
  add_foreign_key "subscriptions", "users"
end
