class BlogEntry < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :site
  # 🚅 add belongs_to associations above.

  has_many :blog_articles, dependent: :destroy
  has_many :blog_cards, dependent: :destroy
  has_many :blog_lists, through: :blog_cards
  # 🚅 add has_many associations above.

  has_one :team, through: :site
  has_one_attached :hero_image
  # 🚅 add has_one associations above.

  scope :published,    -> {where("publish_at <= ?", Date.current)}
  # 🚅 add scopes above.

  validates :title, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
