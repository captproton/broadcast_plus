class Api::V1::SettingMediaAppearancesPageSerializer < Api::V1::ApplicationSerializer
  set_type "setting_media_appearances_page"

  attributes :id,
    :site_id,
    :hero_title,
    :hero_image,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
