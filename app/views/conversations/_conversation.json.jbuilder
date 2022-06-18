json.extract! conversation, :id, :contact_id, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
