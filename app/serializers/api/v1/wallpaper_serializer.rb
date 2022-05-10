class Api::V1::WallpaperSerializer < Api::V1::ApplicationSerializer
  set_type "wallpaper"

  attributes :id,
    :site_id,
    :name,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
