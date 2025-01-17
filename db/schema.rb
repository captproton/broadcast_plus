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

ActiveRecord::Schema[7.0].define(version: 2022_06_16_022014) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_mailbox_inbound_emails", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "message_id", null: false
    t.string "message_checksum", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id", "message_checksum"], name: "index_action_mailbox_inbound_emails_uniqueness", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "biographies", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.string "title"
    t.string "header_photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_biographies_on_site_id"
  end

  create_table "blog_articles", force: :cascade do |t|
    t.bigint "blog_entry_id", null: false
    t.integer "pinned_value"
    t.integer "last_updated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "byline"
    t.string "name"
    t.index ["blog_entry_id"], name: "index_blog_articles_on_blog_entry_id"
  end

  create_table "blog_cards", force: :cascade do |t|
    t.bigint "blog_list_id", null: false
    t.bigint "blog_entry_id", null: false
    t.string "title"
    t.integer "pin_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_entry_id"], name: "index_blog_cards_on_blog_entry_id"
    t.index ["blog_list_id"], name: "index_blog_cards_on_blog_list_id"
  end

  create_table "blog_entries", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.string "title"
    t.integer "pinned_value"
    t.datetime "publish_at"
    t.string "seo_title"
    t.text "seo_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_blog_entries_on_site_id"
  end

  create_table "blog_lists", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "site_id", null: false
    t.text "description"
    t.index ["site_id"], name: "index_blog_lists_on_site_id"
  end

  create_table "books", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.string "title"
    t.string "byline"
    t.text "description"
    t.text "jacket_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_books_on_site_id"
  end

  create_table "contact_messages", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "subject"
    t.bigint "site_id", null: false
    t.index ["site_id"], name: "index_contact_messages_on_site_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
    t.index ["contact_id"], name: "index_conversations_on_contact_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.string "title"
    t.date "start_date"
    t.date "finish_date"
    t.text "more_info_url"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_events_on_site_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_images_on_site_id"
  end

  create_table "integrations_stripe_installations", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.bigint "oauth_stripe_account_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["oauth_stripe_account_id"], name: "index_stripe_installations_on_stripe_account_id"
    t.index ["team_id"], name: "index_integrations_stripe_installations_on_team_id"
  end

  create_table "invitations", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "uuid"
    t.integer "from_membership_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "team_id"
    t.index ["team_id"], name: "index_invitations_on_team_id"
  end

  create_table "leads", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.text "email_address"
    t.text "subject"
    t.text "message_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "legal_texts", force: :cascade do |t|
    t.string "title"
    t.bigint "site_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_legal_texts_on_site_id"
  end

  create_table "media_appearances", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.string "title"
    t.date "published_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "article_url"
    t.index ["site_id"], name: "index_media_appearances_on_site_id"
  end

  create_table "memberships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "invitation_id"
    t.string "user_first_name"
    t.string "user_last_name"
    t.string "user_profile_photo_id"
    t.string "user_email"
    t.bigint "added_by_id"
    t.bigint "platform_agent_of_id"
    t.jsonb "role_ids", default: []
    t.index ["added_by_id"], name: "index_memberships_on_added_by_id"
    t.index ["invitation_id"], name: "index_memberships_on_invitation_id"
    t.index ["platform_agent_of_id"], name: "index_memberships_on_platform_agent_of_id"
    t.index ["team_id"], name: "index_memberships_on_team_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "memberships_reassignments_assignments", force: :cascade do |t|
    t.integer "membership_id", null: false
    t.integer "scaffolding_completely_concrete_tangible_things_reassignments_i"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["membership_id"], name: "index_memberships_reassignments_assignments_on_membership_id"
    t.index ["scaffolding_completely_concrete_tangible_things_reassignments_i"], name: "index_assignments_on_tangible_things_reassignment_id"
  end

  create_table "memberships_reassignments_scaffolding_completely_concrete_tangi", force: :cascade do |t|
    t.integer "membership_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["membership_id"], name: "index_tangible_things_reassignments_on_membership_id"
  end

  create_table "merchandise_links", force: :cascade do |t|
    t.string "seller_name"
    t.string "item_url"
    t.bigint "book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_merchandise_links_on_book_id"
  end

  create_table "names", force: :cascade do |t|
    t.text "url"
    t.string "font_awesome_class"
    t.string "network_kind"
    t.string "blurb"
    t.text "svg_logo"
    t.text "svg_logo_style"
    t.integer "frontpage_ranking", default: 0, null: false
    t.integer "sidebar_ranking", default: 0, null: false
    t.integer "footer_ranking", default: 0, null: false
    t.integer "podcast_ranking", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "revoked_at", precision: nil
    t.string "scopes", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id", null: false
    t.index ["team_id"], name: "index_oauth_applications_on_team_id"
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "oauth_stripe_accounts", force: :cascade do |t|
    t.string "uid"
    t.jsonb "data"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["uid"], name: "index_oauth_stripe_accounts_on_uid", unique: true
    t.index ["user_id"], name: "index_oauth_stripe_accounts_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.string "author_type", null: false
    t.bigint "author_id", null: false
    t.string "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_posts_on_author"
    t.index ["conversation_id"], name: "index_posts_on_conversation_id"
  end

  create_table "press_kit_entries", force: :cascade do |t|
    t.text "title"
    t.text "article_link"
    t.date "publish_on"
    t.datetime "release_at"
    t.bigint "setting_press_kit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["setting_press_kit_id"], name: "index_press_kit_entries_on_setting_press_kit_id"
  end

  create_table "press_kit_links", force: :cascade do |t|
    t.bigint "setting_press_kit_id", null: false
    t.text "label"
    t.text "url"
    t.text "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["setting_press_kit_id"], name: "index_press_kit_links_on_setting_press_kit_id"
  end

  create_table "press_kit_photo_and_headshots", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.text "dimensions_wxh"
    t.text "headshot_or_other"
    t.date "publish_at"
    t.bigint "setting_press_kit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["setting_press_kit_id"], name: "index_press_kit_photo_and_headshots_on_setting_press_kit_id"
  end

  create_table "publisher_accounts", force: :cascade do |t|
    t.string "name"
    t.text "url"
    t.string "font_awesome_class"
    t.string "network_kind"
    t.string "blurb"
    t.text "svg_logo"
    t.text "svg_logo_style"
    t.integer "frontpage_ranking", default: 0, null: false
    t.integer "sidebar_ranking", default: 0, null: false
    t.integer "footer_ranking", default: 0, null: false
    t.integer "podcast_ranking", default: 0, null: false
    t.bigint "site_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_publisher_accounts_on_site_id"
  end

  create_table "scaffolding_absolutely_abstract_creative_concepts", force: :cascade do |t|
    t.integer "team_id", null: false
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_absolutely_abstract_creative_concepts_on_team_id"
  end

  create_table "scaffolding_absolutely_abstract_creative_concepts_collaborators", force: :cascade do |t|
    t.bigint "creative_concept_id", null: false
    t.bigint "membership_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "role_ids", default: []
    t.index ["creative_concept_id"], name: "index_creative_concepts_collaborators_on_creative_concept_id"
    t.index ["membership_id"], name: "index_creative_concepts_collaborators_on_membership_id"
  end

  create_table "scaffolding_completely_concrete_tangible_things", force: :cascade do |t|
    t.integer "absolutely_abstract_creative_concept_id", null: false
    t.string "text_field_value"
    t.string "button_value"
    t.string "cloudinary_image_value"
    t.date "date_field_value"
    t.string "email_field_value"
    t.string "password_field_value"
    t.string "phone_field_value"
    t.string "super_select_value"
    t.text "text_area_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sort_order"
    t.datetime "date_and_time_field_value", precision: nil
    t.jsonb "multiple_button_values", default: []
    t.jsonb "multiple_super_select_values", default: []
    t.string "color_picker_value"
    t.boolean "boolean_button_value"
    t.string "option_value"
    t.jsonb "multiple_option_values", default: []
    t.index ["absolutely_abstract_creative_concept_id"], name: "index_tangible_things_on_creative_concept_id"
  end

  create_table "scaffolding_completely_concrete_tangible_things_assignments", force: :cascade do |t|
    t.bigint "tangible_thing_id"
    t.bigint "membership_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["membership_id"], name: "index_tangible_things_assignments_on_membership_id"
    t.index ["tangible_thing_id"], name: "index_tangible_things_assignments_on_tangible_thing_id"
  end

  create_table "setting_biographies", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_biographies_on_site_id"
  end

  create_table "setting_book_collection_pages", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_book_collection_pages_on_site_id"
  end

  create_table "setting_event_pages", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "hero_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_event_pages_on_site_id"
  end

  create_table "setting_first_times", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "first_name"
    t.text "last_name"
    t.text "blurb"
    t.text "twitter_handle"
    t.text "featured_image_src"
    t.text "featured_youtube_video_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hero_title"
    t.string "name"
    t.text "youtube_video_poster_photo_url"
    t.index ["site_id"], name: "index_setting_first_times_on_site_id"
  end

  create_table "setting_general_infos", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "site_name"
    t.text "plain_text_name"
    t.text "text_number"
    t.text "newsletter_subscription_url"
    t.text "default_meta_blurb"
    t.boolean "is_team_website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_general_infos_on_site_id"
  end

  create_table "setting_get_in_contact_contents", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "first_name"
    t.text "last_name"
    t.text "youtube_url"
    t.text "youtube_image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_get_in_contact_contents_on_site_id"
  end

  create_table "setting_hire_mes", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "title"
    t.text "learn_more_text"
    t.text "learn_more_pdf_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_hire_mes_on_site_id"
  end

  create_table "setting_home_infos", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "biography_blurb"
    t.text "video_billboard_url"
    t.text "watch_this_video_url"
    t.text "bio_link_label"
    t.text "watch_this_poster_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_home_infos_on_site_id"
  end

  create_table "setting_media_appearances_pages", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "hero_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_media_appearances_pages_on_site_id"
  end

  create_table "setting_podcast_pages", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "hero_title"
    t.text "title"
    t.text "podcast_player_src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_podcast_pages_on_site_id"
  end

  create_table "setting_podcasts", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "hero_title"
    t.text "title"
    t.text "podcast_player_src"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_podcasts_on_site_id"
  end

  create_table "setting_press_kits", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.text "hero_title"
    t.text "name"
    t.date "birthdate"
    t.text "birthplace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_setting_press_kits_on_site_id"
  end

  create_table "sites", force: :cascade do |t|
    t.bigint "team_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subdomain"
    t.text "domain"
    t.index ["team_id"], name: "index_sites_on_team_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.string "tagger_type"
    t.bigint "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
    t.index ["tagger_type", "tagger_id"], name: "index_taggings_on_tagger_type_and_tagger_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.boolean "being_destroyed"
    t.string "time_zone"
    t.string "locale"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: nil
    t.datetime "last_sign_in_at", precision: nil
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "current_team_id"
    t.string "first_name"
    t.string "last_name"
    t.string "time_zone"
    t.datetime "last_seen_at", precision: nil
    t.string "profile_photo_id"
    t.jsonb "ability_cache"
    t.datetime "last_notification_email_sent_at", precision: nil
    t.boolean "former_user", default: false, null: false
    t.string "encrypted_otp_secret"
    t.string "encrypted_otp_secret_iv"
    t.string "encrypted_otp_secret_salt"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login"
    t.string "otp_backup_codes", array: true
    t.string "locale"
    t.bigint "platform_agent_of_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["platform_agent_of_id"], name: "index_users_on_platform_agent_of_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallpapers", force: :cascade do |t|
    t.bigint "site_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["site_id"], name: "index_wallpapers_on_site_id"
  end

  create_table "webhooks_incoming_bullet_train_webhooks", force: :cascade do |t|
    t.jsonb "data"
    t.datetime "processed_at", precision: nil
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "verified_at", precision: nil
  end

  create_table "webhooks_incoming_oauth_stripe_account_webhooks", force: :cascade do |t|
    t.jsonb "data"
    t.datetime "processed_at", precision: nil
    t.datetime "verified_at", precision: nil
    t.bigint "oauth_stripe_account_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["oauth_stripe_account_id"], name: "index_stripe_webhooks_on_stripe_account_id"
  end

  create_table "webhooks_outgoing_deliveries", force: :cascade do |t|
    t.integer "endpoint_id"
    t.integer "event_id"
    t.text "endpoint_url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.datetime "delivered_at", precision: nil
  end

  create_table "webhooks_outgoing_delivery_attempts", force: :cascade do |t|
    t.integer "delivery_id"
    t.integer "response_code"
    t.text "response_body"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.text "response_message"
    t.text "error_message"
    t.integer "attempt_number"
  end

  create_table "webhooks_outgoing_endpoints", force: :cascade do |t|
    t.bigint "team_id"
    t.text "url"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "name"
    t.jsonb "event_type_ids", default: []
    t.index ["team_id"], name: "index_webhooks_outgoing_endpoints_on_team_id"
  end

  create_table "webhooks_outgoing_events", force: :cascade do |t|
    t.integer "subject_id"
    t.string "subject_type"
    t.jsonb "data"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "team_id"
    t.string "uuid"
    t.jsonb "payload"
    t.string "event_type_id"
    t.index ["team_id"], name: "index_webhooks_outgoing_events_on_team_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "biographies", "sites"
  add_foreign_key "blog_articles", "blog_entries"
  add_foreign_key "blog_cards", "blog_entries"
  add_foreign_key "blog_cards", "blog_lists"
  add_foreign_key "blog_entries", "sites"
  add_foreign_key "blog_lists", "sites"
  add_foreign_key "books", "sites"
  add_foreign_key "contact_messages", "sites"
  add_foreign_key "conversations", "contacts"
  add_foreign_key "events", "sites"
  add_foreign_key "images", "sites"
  add_foreign_key "integrations_stripe_installations", "oauth_stripe_accounts"
  add_foreign_key "integrations_stripe_installations", "teams"
  add_foreign_key "invitations", "teams"
  add_foreign_key "legal_texts", "sites"
  add_foreign_key "media_appearances", "sites"
  add_foreign_key "memberships", "invitations"
  add_foreign_key "memberships", "memberships", column: "added_by_id"
  add_foreign_key "memberships", "oauth_applications", column: "platform_agent_of_id"
  add_foreign_key "memberships", "teams"
  add_foreign_key "memberships", "users"
  add_foreign_key "memberships_reassignments_assignments", "memberships"
  add_foreign_key "memberships_reassignments_assignments", "memberships_reassignments_scaffolding_completely_concrete_tangi", column: "scaffolding_completely_concrete_tangible_things_reassignments_i"
  add_foreign_key "memberships_reassignments_scaffolding_completely_concrete_tangi", "memberships"
  add_foreign_key "merchandise_links", "books"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_applications", "teams"
  add_foreign_key "oauth_stripe_accounts", "users"
  add_foreign_key "posts", "conversations"
  add_foreign_key "press_kit_entries", "setting_press_kits"
  add_foreign_key "press_kit_links", "setting_press_kits"
  add_foreign_key "press_kit_photo_and_headshots", "setting_press_kits"
  add_foreign_key "publisher_accounts", "sites"
  add_foreign_key "scaffolding_absolutely_abstract_creative_concepts", "teams"
  add_foreign_key "scaffolding_absolutely_abstract_creative_concepts_collaborators", "memberships"
  add_foreign_key "scaffolding_absolutely_abstract_creative_concepts_collaborators", "scaffolding_absolutely_abstract_creative_concepts", column: "creative_concept_id"
  add_foreign_key "scaffolding_completely_concrete_tangible_things", "scaffolding_absolutely_abstract_creative_concepts", column: "absolutely_abstract_creative_concept_id"
  add_foreign_key "scaffolding_completely_concrete_tangible_things_assignments", "memberships"
  add_foreign_key "scaffolding_completely_concrete_tangible_things_assignments", "scaffolding_completely_concrete_tangible_things", column: "tangible_thing_id"
  add_foreign_key "setting_biographies", "sites"
  add_foreign_key "setting_book_collection_pages", "sites"
  add_foreign_key "setting_event_pages", "sites"
  add_foreign_key "setting_first_times", "sites"
  add_foreign_key "setting_general_infos", "sites"
  add_foreign_key "setting_get_in_contact_contents", "sites"
  add_foreign_key "setting_hire_mes", "sites"
  add_foreign_key "setting_home_infos", "sites"
  add_foreign_key "setting_media_appearances_pages", "sites"
  add_foreign_key "setting_podcast_pages", "sites"
  add_foreign_key "setting_podcasts", "sites"
  add_foreign_key "setting_press_kits", "sites"
  add_foreign_key "sites", "teams"
  add_foreign_key "taggings", "tags"
  add_foreign_key "users", "oauth_applications", column: "platform_agent_of_id"
  add_foreign_key "wallpapers", "sites"
  add_foreign_key "webhooks_outgoing_endpoints", "teams"
  add_foreign_key "webhooks_outgoing_events", "teams"
end
