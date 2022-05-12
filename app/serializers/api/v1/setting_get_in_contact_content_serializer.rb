class Api::V1::SettingGetInContactContentSerializer < Api::V1::ApplicationSerializer
  set_type "setting_get_in_contact_content"

  attributes :id,
    :site_id,
    :first_name,
    :last_name,
    :youtube_url,
    :youtube_image_url,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
