class Api::V1::PublisherAccountSerializer < Api::V1::ApplicationSerializer
  set_type "publisher_account"

  attributes :id,
    :site_id,
    :name,
    :url,
    :font_awesome_class,
    :network_kind,
    :blurb,
    :svg_logo,
    :svg_logo_style,
    :frontpage_ranking,
    :sidebar_ranking,
    :footer_ranking,
    :podcast_ranking,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
