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
  has_one_attached :image
  # 🚅 add has_one associations above.

    scope :featured, -> { where("pinned_value > ?", 0)
                        .order(pinned_value: :desc)
                        .first(3)}

  scope :featured_2nd_and_3rd, -> { where("pinned_value > ?", 0)
                        .order(pinned_value: :desc)
                        .first(3).last(2)}

  scope :featured_on_aside, -> {  where("pinned_value > ?", 0)
                                  .order(pinned_value: :desc)
                                  .first(5).last(2)}

  scope :published, -> {  where("publish_at is not ?", nil)
                          .where("publish_at < ?", Time.now)}

  # 🚅 add scopes above.

  validates :title, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
