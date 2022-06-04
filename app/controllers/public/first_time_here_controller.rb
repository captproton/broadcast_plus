class Public::FirstTimeHereController < Public::CustomerSite::BaseController
  before_action :set_page
  layout "frontdoor"

  # GET /first_time_here
  def show
    @sidebar_icons              = PublisherAccount.sidebar_icons(@site).first(5)


  end


  def set_page
    @page_info = @site.setting_first_times.first
    @hero_image_url   = url_for(@page_info.hero_image)
    @site_general_info = @site.setting_general_infos.first
  end

end
