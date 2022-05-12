class Api::V1::SettingPodcastSerializer < Api::V1::ApplicationSerializer
  set_type "setting_podcast"

  attributes :id,
    :site_id,
    :hero_title,
    :hero_image,
    :title,
    :podcast_player_src,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
