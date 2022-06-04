class Public::HomeController < Public::CustomerSite::BaseController
  before_action :set_home_page
  layout "frontdoor"

  # GET /
  def index
    # @ = @site.events
    @home_info = @site.setting_home_infos.first
  end


  def set_home_page
    @page                = @site.setting_home_infos.first
    @home_info          = @page
    # @hero_image_url   = url_for(@page.hero_image)
    @frontpage_icons    = PublisherAccount.frontpage_icons
    @site_general_info  = @site.setting_general_infos.first
  end
end
