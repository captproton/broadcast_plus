class BlogCard < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :blog_list
  belongs_to :blog_entry
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :blog_entry, scope: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

  def parent_entry
    be = self.blog_entry
  end

  def parent_article
    blog_entry.blog_articles.first
  end

  def card_title
    parent_entry.title
  end

  def valid_blog_entries
    blog_list.valid_blog_entries
  end

  def hero_image
    hi = parent_entry.hero_image
  end
  
  def blurb
    ba = parent_entry.blog_articles.first
    ba.body
  end
  # 🚅 add methods above.
end
