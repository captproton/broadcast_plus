class BlogArticle < ApplicationRecord
  WORDS_PER_MINUTE = 150
  # 🚅 add concerns above.

  belongs_to :blog_entry
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :blog_entry
  has_rich_text :body
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :pinned_value, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.
  def reading_time
    # https://alexanderpaterson.com/posts/showing-estimated-reading-time-on-a-rails-blog-post
    words_per_minute = 150
    text =  self.body.to_plain_text
    result = (text.scan(/\w+/).length / WORDS_PER_MINUTE).to_i ||= 1
  end

  def self.collect_pinned
    where("pinned_value > ?", 0)
  end

  # 🚅 add methods above.
end
