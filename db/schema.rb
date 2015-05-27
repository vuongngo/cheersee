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

ActiveRecord::Schema.define(version: 20150108114207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_mes", force: true do |t|
    t.integer  "user_id"
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_mes", ["user_id"], name: "index_contact_mes_on_user_id", using: :btree

  create_table "feedbacks", force: true do |t|
    t.integer  "reference_id"
    t.integer  "time_management_id"
    t.integer  "rate"
    t.integer  "friendly"
    t.integer  "fun"
    t.integer  "confidence"
    t.integer  "curiosity"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feedbacks", ["reference_id"], name: "index_feedbacks_on_reference_id", using: :btree

  create_table "friend_messages", force: true do |t|
    t.integer  "friendship_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friend_messages", ["friendship_id"], name: "index_friend_messages_on_friendship_id", using: :btree
  add_index "friend_messages", ["user_id"], name: "index_friend_messages_on_user_id", using: :btree

  create_table "friendhashes", force: true do |t|
    t.integer  "user_id"
    t.text     "token"
    t.datetime "expired_at"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendhashes", ["user_id", "token"], name: "index_friendhashes_on_user_id_and_token", unique: true, using: :btree
  add_index "friendhashes", ["user_id"], name: "index_friendhashes_on_user_id", using: :btree

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "accepted",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true, using: :btree
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id", using: :btree

  create_table "general_notification_counts", force: true do |t|
    t.integer  "user_id"
    t.integer  "unread_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "general_notification_counts", ["user_id"], name: "index_general_notification_counts_on_user_id", using: :btree

  create_table "general_notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "sender_id"
    t.string   "mes"
    t.integer  "join_challenge_id"
    t.integer  "set_challenge_id"
    t.integer  "reference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "general_notifications", ["user_id"], name: "index_general_notifications_on_user_id", using: :btree

  create_table "hangout_messages", force: true do |t|
    t.integer  "hangout_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hangout_messages", ["hangout_id"], name: "index_hangout_messages_on_hangout_id", using: :btree
  add_index "hangout_messages", ["user_id"], name: "index_hangout_messages_on_user_id", using: :btree

  create_table "hangout_notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "unread_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hangout_notifications", ["user_id"], name: "index_hangout_notifications_on_user_id", using: :btree

  create_table "hangouts", force: true do |t|
    t.text     "business_name"
    t.text     "business_location"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "share_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "join_challenge_comments", force: true do |t|
    t.integer  "join_challenge_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "join_challenge_comments", ["join_challenge_id"], name: "index_join_challenge_comments_on_join_challenge_id", using: :btree

  create_table "join_challenge_favs", force: true do |t|
    t.integer  "join_challenge_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "join_challenge_favs", ["join_challenge_id"], name: "index_join_challenge_favs_on_join_challenge_id", using: :btree
  add_index "join_challenge_favs", ["user_id"], name: "index_join_challenge_favs_on_user_id", using: :btree

  create_table "join_challenges", force: true do |t|
    t.integer  "user_id"
    t.integer  "set_challenge_id"
    t.integer  "point"
    t.float    "longitude"
    t.float    "latitude"
    t.text     "content"
    t.integer  "no_of_fav"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "joinchallenge"
  end

  add_index "join_challenges", ["set_challenge_id"], name: "index_join_challenges_on_set_challenge_id", using: :btree
  add_index "join_challenges", ["user_id"], name: "index_join_challenges_on_user_id", using: :btree

  create_table "leaderboard_challenges", force: true do |t|
    t.integer  "set_challenge_id"
    t.integer  "first_place"
    t.integer  "first_point"
    t.text     "first_badge"
    t.string   "firstpic"
    t.integer  "second_place"
    t.integer  "second_point"
    t.text     "second_badge"
    t.string   "secondpic"
    t.integer  "third_place"
    t.integer  "third_point"
    t.text     "third_badge"
    t.string   "thirdpic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "leaderboard_challenges", ["set_challenge_id"], name: "index_leaderboard_challenges_on_set_challenge_id", using: :btree

  create_table "locations", force: true do |t|
    t.integer  "user_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "user_time_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "locations", ["user_id"], name: "index_locations_on_user_id", using: :btree

  create_table "manage_challenges", force: true do |t|
    t.integer  "user_id"
    t.integer  "set_challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "manage_challenges", ["set_challenge_id"], name: "index_manage_challenges_on_set_challenge_id", using: :btree
  add_index "manage_challenges", ["user_id", "set_challenge_id"], name: "index_manage_challenges_on_user_id_and_set_challenge_id", unique: true, using: :btree
  add_index "manage_challenges", ["user_id"], name: "index_manage_challenges_on_user_id", using: :btree

  create_table "message_notifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "unread_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "message_notifications", ["user_id"], name: "index_message_notifications_on_user_id", using: :btree

  create_table "my_metrics", force: true do |t|
    t.integer  "no_of_user"
    t.integer  "no_of_challenge"
    t.integer  "no_of_join_challenge"
    t.integer  "no_of_share_meetup"
    t.integer  "no_of_hangout"
    t.integer  "no_of_reference"
    t.integer  "no_of_location_search"
    t.date     "every_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "potential_relationships", force: true do |t|
    t.integer  "user_id"
    t.integer  "stranger_id"
    t.integer  "like_no"
    t.integer  "comment_no"
    t.integer  "joint_no"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preferences", force: true do |t|
    t.integer  "user_id"
    t.text     "intro"
    t.text     "passion"
    t.text     "interest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar"
    t.string   "gender"
    t.integer  "age"
    t.string   "hometown"
  end

  add_index "profiles", ["age"], name: "index_profiles_on_age", using: :btree
  add_index "profiles", ["gender"], name: "index_profiles_on_gender", using: :btree
  add_index "profiles", ["hometown"], name: "index_profiles_on_hometown", using: :btree
  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "question_answers", force: true do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "references", force: true do |t|
    t.integer  "user_id"
    t.integer  "receiver_id"
    t.integer  "hangout_id"
    t.boolean  "feed",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "references", ["receiver_id"], name: "index_references_on_receiver_id", using: :btree
  add_index "references", ["user_id"], name: "index_references_on_user_id", using: :btree

  create_table "reputations", force: true do |t|
    t.integer  "user_id"
    t.float    "time_early"
    t.float    "time_late"
    t.float    "never_come"
    t.float    "rate_av"
    t.float    "friendly_av"
    t.float    "fun_av"
    t.float    "confidence_av"
    t.float    "curiosity_av"
    t.integer  "number_of_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reputations", ["user_id"], name: "index_reputations_on_user_id", using: :btree

  create_table "request_hangouts", force: true do |t|
    t.integer  "user_id"
    t.integer  "share_hangout_id"
    t.text     "mes"
    t.boolean  "accept",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "request_hangouts", ["share_hangout_id"], name: "index_request_hangouts_on_share_hangout_id", using: :btree
  add_index "request_hangouts", ["user_id", "share_hangout_id"], name: "index_request_hangouts_on_user_id_and_share_hangout_id", unique: true, using: :btree
  add_index "request_hangouts", ["user_id"], name: "index_request_hangouts_on_user_id", using: :btree

  create_table "set_challenge_comments", force: true do |t|
    t.integer  "set_challenge_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "set_challenge_comments", ["set_challenge_id"], name: "index_set_challenge_comments_on_set_challenge_id", using: :btree

  create_table "set_challenge_favs", force: true do |t|
    t.integer  "set_challenge_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "set_challenge_favs", ["set_challenge_id"], name: "index_set_challenge_favs_on_set_challenge_id", using: :btree
  add_index "set_challenge_favs", ["user_id"], name: "index_set_challenge_favs_on_user_id", using: :btree

  create_table "set_challenges", force: true do |t|
    t.integer  "user_id"
    t.text     "post"
    t.integer  "time_span"
    t.string   "point_metric"
    t.string   "point_measure"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "no_of_fav"
    t.boolean  "international", default: false
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "setchallenge"
  end

  add_index "set_challenges", ["user_id"], name: "index_set_challenges_on_user_id", using: :btree

  create_table "share_hangout_mates", force: true do |t|
    t.integer  "share_hangout_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "share_hangouts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "share_time",                        null: false
    t.string   "business_location"
    t.float    "longitude"
    t.float    "latitude"
    t.string   "business_name"
    t.boolean  "notify_friend",     default: true
    t.boolean  "open_nearby",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "specific_share"
  end

  add_index "share_hangouts", ["user_id", "created_at"], name: "index_share_hangouts_on_user_id_and_created_at", using: :btree
  add_index "share_hangouts", ["user_id"], name: "index_share_hangouts_on_user_id", using: :btree

  create_table "simple_hashtag_hashtaggings", force: true do |t|
    t.integer "hashtag_id"
    t.integer "hashtaggable_id"
    t.string  "hashtaggable_type"
  end

  add_index "simple_hashtag_hashtaggings", ["hashtag_id"], name: "index_simple_hashtag_hashtaggings_on_hashtag_id", using: :btree
  add_index "simple_hashtag_hashtaggings", ["hashtaggable_id", "hashtaggable_type"], name: "index_hashtaggings_hashtaggable_id_hashtaggable_type", using: :btree

  create_table "simple_hashtag_hashtags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tag_maps", force: true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_maps", ["tag_id"], name: "index_tag_maps_on_tag_id", using: :btree
  add_index "tag_maps", ["user_id", "tag_id"], name: "index_tag_maps_on_user_id_and_tag_id", unique: true, using: :btree
  add_index "tag_maps", ["user_id"], name: "index_tag_maps_on_user_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_managements", force: true do |t|
    t.text     "manage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_addresses", force: true do |t|
    t.integer  "user_id"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "who_hangouts", force: true do |t|
    t.integer  "hangout_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "who_hangouts", ["hangout_id"], name: "index_who_hangouts_on_hangout_id", using: :btree
  add_index "who_hangouts", ["user_id"], name: "index_who_hangouts_on_user_id", using: :btree

end
