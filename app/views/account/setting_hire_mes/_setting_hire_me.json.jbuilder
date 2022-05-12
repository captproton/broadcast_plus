json.extract! setting_hire_me,
  :id,
  :site_id,
  :title,
  :learn_more_text,
  :learn_more_pdf,
  # 🚅 super scaffolding will insert new fields above this line.
  :created_at,
  :updated_at
json.url account_setting_hire_me_url(setting_hire_me, format: :json)
