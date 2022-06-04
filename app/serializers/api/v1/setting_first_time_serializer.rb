class Api::V1::SettingFirstTimeSerializer < Api::V1::ApplicationSerializer
  set_type "setting_first_time"

  attributes :id,
    :site_id,
    :hero_title,
    :hero_image,
    :first_name,
    :last_name,
    :featured_aside_image,
    :blurb,
    :twitter_handle,
    :featured_youtube_video_url,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
