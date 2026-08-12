class CreateCoreTables < ActiveRecord::Migration[7.2]
  def change
    create_table :request_for_comments do |t|
      t.string :tid, null: false
      t.string :number, null: false
      t.text :description, null: false
      t.string :author_id, null: false
      t.timestamps
    end
    add_index :request_for_comments, :tid, unique: true
    add_index :request_for_comments, :number, unique: true

    create_table :approvals do |t|
      t.references :request_for_comment, null: false, foreign_key: true
      t.string :developer_id, null: false
      t.timestamps
    end

    create_table :rfc_event_stores do |t|
      t.string :event_id, null: false
      t.string :event_type, null: false
      t.string :stream_name, null: false
      t.text :data, null: false
      t.string :correlation_id
      t.string :causation_id
      t.datetime :occurred_at, null: false
      t.timestamps
    end
    add_index :rfc_event_stores, [:event_id, :stream_name], unique: true
    add_index :rfc_event_stores, [:stream_name, :id]

    create_table :rfc_number_sequences do |t|
      t.timestamps
    end

    create_table :incoming_webhooks do |t|
      t.string :service, null: false
      t.text :data, null: false
      t.datetime :handled_at
      t.boolean :handled_result, null: false, default: false
      t.timestamps
    end

    create_table :number_of_rfc_issued_by_developer do |t|
      t.string :developer_id, null: false
      t.integer :value, null: false, default: 0
      t.timestamps
    end
    add_index :number_of_rfc_issued_by_developer, :developer_id, unique: true
  end
end
