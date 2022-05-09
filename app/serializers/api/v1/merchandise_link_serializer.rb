class Api::V1::MerchandiseLinkSerializer < Api::V1::ApplicationSerializer
  set_type "merchandise_link"

  attributes :id,
    :book_id,
    :seller_name,
    :item_url,
    # 🚅 super scaffolding will insert new fields above this line.
    :created_at,
    :updated_at

  belongs_to :book, serializer: Api::V1::BookSerializer
end
