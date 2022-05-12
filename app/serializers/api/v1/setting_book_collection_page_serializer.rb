class Api::V1::SettingBookCollectionPageSerializer < Api::V1::ApplicationSerializer
  set_type "setting_book_collection_page"

  attributes :id,
    :site_id,
    :title,
    :hero_image,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :site, serializer: Api::V1::SiteSerializer
end
