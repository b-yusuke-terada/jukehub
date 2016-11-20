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

ActiveRecord::Schema.define(version: 20161120045451) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_accounts_on_provider_and_uid", unique: true, using: :btree
  end

  create_table "comment_reactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.integer  "reaction_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["comment_id"], name: "index_comment_reactions_on_comment_id", using: :btree
    t.index ["reaction_type"], name: "index_comment_reactions_on_reaction_type", using: :btree
    t.index ["user_id"], name: "index_comment_reactions_on_user_id", using: :btree
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "queue_id"
    t.integer  "reference_comment_id"
    t.integer  "user_id"
    t.text     "body",                 limit: 65535
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["queue_id"], name: "index_comments_on_queue_id", using: :btree
    t.index ["reference_comment_id"], name: "index_comments_on_reference_comment_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "oauth_access_grants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "resource_owner_id",               null: false
    t.integer  "application_id",                  null: false
    t.string   "token",                           null: false
    t.integer  "expires_in",                      null: false
    t.text     "redirect_uri",      limit: 65535, null: false
    t.datetime "created_at",                      null: false
    t.datetime "revoked_at"
    t.string   "scopes"
    t.index ["application_id"], name: "fk_rails_b4b53e07b8", using: :btree
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree
  end

  create_table "oauth_access_tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "resource_owner_id"
    t.integer  "application_id"
    t.string   "token",                               null: false
    t.string   "refresh_token"
    t.integer  "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at",                          null: false
    t.string   "scopes"
    t.string   "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "fk_rails_732cb83ab7", using: :btree
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree
  end

  create_table "oauth_applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                    null: false
    t.string   "uid",                                     null: false
    t.string   "secret",                                  null: false
    t.text     "redirect_uri", limit: 65535,              null: false
    t.string   "scopes",                     default: "", null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree
  end

  create_table "organization_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "organization_id"
    t.integer  "user_id"
    t.integer  "state"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["organization_id"], name: "index_organization_users_on_organization_id", using: :btree
    t.index ["state"], name: "index_organization_users_on_state", using: :btree
    t.index ["user_id"], name: "index_organization_users_on_user_id", using: :btree
  end

  create_table "organizations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "screen_name"
    t.text     "description", limit: 65535
    t.boolean  "is_public",                 default: true
    t.integer  "state",                     default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["is_public"], name: "index_organizations_on_is_public", using: :btree
    t.index ["name"], name: "index_organizations_on_name", using: :btree
    t.index ["state"], name: "index_organizations_on_state", using: :btree
  end

  create_table "queue_reactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "queue_id"
    t.integer  "user_id"
    t.integer  "reaction_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["queue_id"], name: "index_queue_reactions_on_queue_id", using: :btree
    t.index ["reaction_type"], name: "index_queue_reactions_on_reaction_type", using: :btree
    t.index ["user_id"], name: "index_queue_reactions_on_user_id", using: :btree
  end

  create_table "reactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "queue_id"
    t.integer  "reference_comment_id"
    t.integer  "user_id"
    t.integer  "reaction_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["queue_id"], name: "index_reactions_on_queue_id", using: :btree
    t.index ["reaction_type"], name: "index_reactions_on_reaction_type", using: :btree
    t.index ["reference_comment_id"], name: "index_reactions_on_reference_comment_id", using: :btree
    t.index ["user_id"], name: "index_reactions_on_user_id", using: :btree
  end

  create_table "room_participants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_room_participants_on_created_at", using: :btree
    t.index ["room_id"], name: "index_room_participants_on_room_id", using: :btree
    t.index ["updated_at"], name: "index_room_participants_on_updated_at", using: :btree
    t.index ["user_id"], name: "index_room_participants_on_user_id", using: :btree
  end

  create_table "room_queues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "room_id"
    t.integer  "video_id"
    t.integer  "user_id"
    t.integer  "state"
    t.datetime "start_at"
    t.datetime "started_at"
    t.datetime "finish_at"
    t.datetime "finished_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["finish_at"], name: "index_room_queues_on_finish_at", using: :btree
    t.index ["finished_at"], name: "index_room_queues_on_finished_at", using: :btree
    t.index ["room_id"], name: "index_room_queues_on_room_id", using: :btree
    t.index ["start_at"], name: "index_room_queues_on_start_at", using: :btree
    t.index ["started_at"], name: "index_room_queues_on_started_at", using: :btree
    t.index ["state"], name: "index_room_queues_on_state", using: :btree
    t.index ["user_id"], name: "index_room_queues_on_user_id", using: :btree
    t.index ["video_id"], name: "index_room_queues_on_video_id", using: :btree
  end

  create_table "rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "organization_id"
    t.string   "screen_name"
    t.text     "description",     limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["organization_id"], name: "index_rooms_on_organization_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email",                  default: "", null: false
    t.string   "name"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["name"], name: "index_users_on_name", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "videos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "provider"
    t.string   "title"
    t.string   "provider_video_id"
    t.integer  "duration"
    t.string   "image_url"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["provider"], name: "index_videos_on_provider", using: :btree
    t.index ["provider_video_id"], name: "index_videos_on_provider_video_id", using: :btree
    t.index ["title"], name: "index_videos_on_title", using: :btree
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
end
