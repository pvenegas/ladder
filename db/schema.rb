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

ActiveRecord::Schema.define(version: 20140306004142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "commentable_id",   null: false
    t.string   "commentable_type", null: false
    t.text     "content",          null: false
    t.integer  "user_id",          null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "game_events", force: true do |t|
    t.integer  "game_id"
    t.string   "state",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_events", ["game_id"], name: "index_game_events_on_game_id", using: :btree

  create_table "game_ranks", force: true do |t|
    t.integer  "game_id",      null: false
    t.integer  "position"
    t.datetime "confirmed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "player_id",    null: false
  end

  add_index "game_ranks", ["game_id", "player_id"], name: "index_game_ranks_on_game_id_and_player_id", unique: true, using: :btree
  add_index "game_ranks", ["game_id"], name: "index_game_ranks_on_game_id", using: :btree

  create_table "games", force: true do |t|
    t.integer  "tournament_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "confirmed_at"
    t.integer  "owner_id",      null: false
  end

  add_index "games", ["owner_id"], name: "index_games_on_owner_id", using: :btree
  add_index "games", ["tournament_id"], name: "index_games_on_tournament_id", using: :btree

  create_table "invite_requests", force: true do |t|
    t.integer  "tournament_id", null: false
    t.integer  "user_id",       null: false
    t.integer  "invite_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invite_requests", ["tournament_id", "user_id"], name: "index_invite_requests_on_tournament_id_and_user_id", unique: true, using: :btree

  create_table "invites", force: true do |t|
    t.integer  "user_id"
    t.integer  "tournament_id"
    t.string   "code",          null: false
    t.string   "email",         null: false
    t.datetime "expires_at",    null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "owner_id",      null: false
  end

  add_index "invites", ["code"], name: "index_invites_on_code", using: :btree
  add_index "invites", ["owner_id"], name: "index_invites_on_owner_id", using: :btree
  add_index "invites", ["tournament_id"], name: "index_invites_on_tournament_id", using: :btree
  add_index "invites", ["user_id"], name: "index_invites_on_user_id", using: :btree

  create_table "pages", force: true do |t|
    t.text     "content"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "pages", ["parent_id"], name: "index_pages_on_parent_id", using: :btree
  add_index "pages", ["parent_type"], name: "index_pages_on_parent_type", using: :btree

  create_table "players", force: true do |t|
    t.integer  "user_id",                          null: false
    t.integer  "tournament_id",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "winning_streak_count", default: 0, null: false
    t.integer  "losing_streak_count",  default: 0, null: false
    t.datetime "end_at"
  end

  add_index "players", ["tournament_id"], name: "index_players_on_tournament_id", using: :btree
  add_index "players", ["user_id", "tournament_id"], name: "index_players_on_user_id_and_tournament_id", unique: true, using: :btree
  add_index "players", ["user_id"], name: "index_players_on_user_id", using: :btree

  create_table "rating_periods", force: true do |t|
    t.integer  "tournament_id", null: false
    t.datetime "period_at",     null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "rating_periods", ["period_at"], name: "index_rating_periods_on_period_at", using: :btree
  add_index "rating_periods", ["tournament_id"], name: "index_rating_periods_on_tournament_id", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "rating_period_id",                           null: false
    t.decimal  "rating",           precision: 38, scale: 10, null: false
    t.decimal  "rating_deviation", precision: 38, scale: 10, null: false
    t.decimal  "volatility",       precision: 38, scale: 10, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "player_id",                                  null: false
  end

  add_index "ratings", ["rating_period_id", "player_id"], name: "index_ratings_on_rating_period_id_and_player_id", unique: true, using: :btree
  add_index "ratings", ["rating_period_id"], name: "index_ratings_on_rating_period_id", using: :btree

  create_table "services", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image_url"
  end

  add_index "services", ["provider"], name: "index_services_on_provider", using: :btree
  add_index "services", ["uid"], name: "index_services_on_uid", using: :btree
  add_index "services", ["user_id"], name: "index_services_on_user_id", using: :btree

  create_table "tournaments", force: true do |t|
    t.string   "name",                       null: false
    t.integer  "owner_id",                   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug"
    t.boolean  "public",     default: false, null: false
  end

  add_index "tournaments", ["public"], name: "index_tournaments_on_public", using: :btree
  add_index "tournaments", ["slug"], name: "index_tournaments_on_slug", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "preferred_service_id"
    t.boolean  "game_confirmed_email", default: true, null: false
    t.boolean  "commented_email",      default: true, null: false
    t.string   "slug"
  end

  add_index "users", ["preferred_service_id"], name: "index_users_on_preferred_service_id", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

end
