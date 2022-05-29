class BlogEntry < ApplicationRecord
  make_taggable # Alias for make_taggable :tags
  make_taggable :skills, :interests, :hashtags
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
  has_rich_text :summary
  # 🚅 add has_one associations above.

  scope :featured, -> { where("pinned_value > ?", 0)
                        .order(pinned_value: :desc)
                        .first(3)}

  scope :featured_2nd_and_3rd, -> { where("pinned_value > ?", 0)
                        .order(pinned_value: :desc)
                        .first(3).last(2)}

  scope :featured_in_section, -> {  where("pinned_value > ?", 0)
                                  .order(pinned_value: :desc)}

  scope :published, -> {  where("publish_at is not ?", nil)
                          .where("publish_at < ?", Time.now)}
                          

  # 🚅 add scopes above.

  validates :title, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.
  def essay
    essay = self.blog_articles.first
  end

  def self.construct_meta_image_url(blog_entry)
    if blog_entry.hero_image.attached?
      url = self.base_url + AttachedImage.new(model= blog_entry,
      image_name="image")
      .url      
    else
      url = self.base_url + AttachedImage.new(model=@site.general_info,
      image_name="meta_image")
      .url
    end

  end

  def self.base_url
    # set conditional for 
      base_url = "https://" + ENV['APPLICATION_HOST'].to_s
  end

  def tag_list
    blog_lists.collect {|x| x.title }.join(", ")
  end

  def self.recommend_entries(site, blog_list_title)
    return [] if blog_list_title.blank?
    blog_list = site.blog_lists.find_by("title = ?", blog_list_title)
    if blog_list.present?
      return blog_list.blog_entries.published.featured_in_section      
    else
      return []
    end
  end

  # 🚅 add methods above.
end
