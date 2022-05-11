class BlogList < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :site
  # 🚅 add belongs_to associations above.

  has_many :blog_cards, dependent: :destroy
  has_many :blog_entries, through: :blog_cards
  # 🚅 add has_many associations above.

  has_one :team, through: :site
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :title, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  def valid_blog_entries
    # raise "please review and implement `valid_blog_entries` in `app/models/blog_list.rb`."
    # please specify what objects should be considered valid for assigning to `blog_entry_ids`.
    # the resulting code should probably look something like `team.blog_entries`.
     @blog_entries = site.blog_entries
  end

  # 🚅 add methods above.
end
