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

ActiveRecord::Schema[7.0].define(version: 2023_02_26_031555) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customer_accounts", force: :cascade do |t|
    t.string "name"
    t.string "customer"
    t.string "manager"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name"
    t.string "resource"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_permissions_on_name", unique: true
  end

  create_table "permissions_profiles", id: false, force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "permission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_permissions_profiles_on_permission_id"
    t.index ["profile_id", "permission_id"], name: "tn_perfil_permiso", unique: true
    t.index ["profile_id"], name: "index_permissions_profiles_on_profile_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_profiles_on_name", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_roles_on_profile_id"
    t.index ["user_id", "profile_id"], name: "index_roles_on_user_id_and_profile_id", unique: true
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.bigint "customer_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_account_id"], name: "index_teams_on_customer_account_id"
  end

  create_table "teams_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "team_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_teams_users_on_team_id"
    t.index ["user_id"], name: "index_teams_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "english_level"
    t.text "technical_knowledge"
    t.string "cv_link"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
