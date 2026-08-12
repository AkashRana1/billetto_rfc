ActiveRecord::Schema[7.2].define(version: 2026_08_11_000001) do
  create_table "approvals", force: :cascade do |t|
    t.integer "request_for_comment_id", null: false
    t.string "developer_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["request_for_comment_id"], name: "index_approvals_on_rfc_id"
  end

  create_table "incoming_webhooks", force: :cascade do |t|
    t.string "service", null: false
    t.text "data", null: false
    t.datetime "handled_at"
    t.boolean "handled_result", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "number_of_rfc_issued_by_developer", force: :cascade do |t|
    t.string "developer_id", null: false
    t.integer "value", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_id"], unique: true
  end

  create_table "request_for_comments", force: :cascade do |t|
    t.string "tid", null: false
    t.string "number", null: false
    t.text "description", null: false
    t.string "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tid"], unique: true
    t.index ["number"], unique: true
  end

  create_table "rfc_event_stores", force: :cascade do |t|
    t.string "event_id", null: false
    t.string "event_type", null: false
    t.string "stream_name", null: false
    t.text "data", null: false
    t.string "correlation_id"
    t.string "causation_id"
    t.datetime "occurred_at", null: false
    t.datetime "created_at", null: false
    t.index ["event_id", "stream_name"], unique: true
    t.index ["stream_name", "id"]
  end

  create_table "rfc_number_sequences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
