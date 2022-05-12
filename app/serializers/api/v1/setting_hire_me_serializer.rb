class Api::V1::SettingHireMeSerializer < Api::V1::ApplicationSerializer
  set_type "setting_hire_me"

  attributes :id,
    :site_id,
    :title,
    :learn_more_text,
    :learn_more_pdf,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
