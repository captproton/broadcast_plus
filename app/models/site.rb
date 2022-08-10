class Site < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :team
  # 🚅 add belongs_to associations above.

  has_many :wallpapers, dependent: :destroy, enable_updates: true
  has_many :books, dependent: :destroy, enable_updates: true
  has_many :contacts, dependent: :destroy
  has_many :contact_messages, dependent: :destroy, enable_updates: true
  has_many :events, dependent: :destroy, enable_updates: true
  has_many :media_appearances, dependent: :destroy, enable_updates: true
  has_many :publisher_accounts, dependent: :destroy, enable_updates: true
  has_many :images, dependent: :destroy, enable_updates: true
  has_many :blog_entries, dependent: :destroy, enable_updates: true
  has_many :blog_lists, dependent: :destroy, enable_updates: true
  has_many :setting_biographies, dependent: :destroy, enable_updates: true
  has_many :setting_book_collection_pages, dependent: :destroy, enable_updates: true
  has_many :setting_general_infos, dependent: :destroy, enable_updates: true
  has_many :setting_home_infos, dependent: :destroy, enable_updates: true
  has_many :setting_first_times, dependent: :destroy, enable_updates: true
  has_many :setting_get_in_contact_contents, dependent: :destroy, enable_updates: true
  has_many :setting_hire_mes, dependent: :destroy, enable_updates: true
  has_many :setting_event_pages, dependent: :destroy, enable_updates: true
  has_many :setting_podcasts, dependent: :destroy, enable_updates: true
  has_many :setting_press_kits, dependent: :destroy, enable_updates: true
  has_many :setting_media_appearances_pages, dependent: :destroy, enable_updates: true
  has_many :setting_podcast_pages, dependent: :destroy, enable_updates: true
  has_many :legal_texts, dependent: :destroy, enable_updates: true
  has_many :newsletters, dependent: :destroy, enable_updates: true
  # 🚅 add has_many associations above.

  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :name, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.
  def general_info
    self.setting_general_infos.first
  end
  # 🚅 add methods above.
end
