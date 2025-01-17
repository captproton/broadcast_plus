class Public::BiographyController < Public::CustomerSite::BaseController
  before_action :set_biogaphy_page
  layout "frontdoor"

  # GET /books
  # GET /books.json
  def index
    # sidebar
    @blog_list_title       = "biography-aside"
    @recommended_entries  = BlogEntry.recommend_entries(@site, @blog_list_title)
    @sidebar_icons              = PublisherAccount.sidebar_icons(@site).first(5)
  end


  def set_biogaphy_page
    @biography_page = @site.setting_biographies.first
    @hero_image_url   = url_for(@biography_page.hero_image)
    @site_general_info = @site.setting_general_infos.first
  end

end
