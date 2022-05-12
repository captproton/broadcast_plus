class Api::V1::SettingHomeInfoSerializer < Api::V1::ApplicationSerializer
  set_type "setting_home_info"

  attributes :id,
    :site_id,
    :biography_blurb,
    :video_billboard_url,
    :watch_this_video_url,
    :bio_link_label,
    :watch_this_poster_url,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
