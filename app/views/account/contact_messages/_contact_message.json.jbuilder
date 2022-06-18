json.extract! contact_message,
  :id,
  :site_id,
  :email,
  :first_name,
  :last_name,
  :phone,
  :subject,
  :body,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_contact_message_url(contact_message, format: :json)
