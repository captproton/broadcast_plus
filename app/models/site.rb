class Site < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :team
  # 🚅 add belongs_to associations above.

  has_many :wallpapers, dependent: :destroy, enable_updates: true
  has_many :books, dependent: :destroy, enable_updates: true
  has_many :events, dependent: :destroy, enable_updates: true
  has_many :media_appearances, dependent: :destroy, enable_updates: true
  has_many :publisher_accounts, dependent: :destroy, enable_updates: true
  has_many :images, dependent: :destroy, enable_updates: true
  has_many :blog_entries, dependent: :destroy, enable_updates: true
  has_many :blog_lists, dependent: :destroy, enable_updates: true
  has_many :setting_biographies, dependent: :destroy, enable_updates: true
  has_many :setting_book_collection_pages, dependent: :destroy, enable_updates: true
  # 🚅 add has_many associations above.

  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :name, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  # 🚅 add methods above.
end
