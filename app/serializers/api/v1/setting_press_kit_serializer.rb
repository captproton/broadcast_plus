class Api::V1::SettingPressKitSerializer < Api::V1::ApplicationSerializer
  set_type "setting_press_kit"

  attributes :id,
    :site_id,
    :hero_title,
    :hero_image,
    :name,
    :birthplace,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
