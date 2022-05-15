class Public::HireMeController < Public::CustomerSite::BaseController
  before_action :set_hire_me_page
  layout "frontdoor"

  # GET /books
  # GET /books.json
  def index
    # @ = @site.events
  end


  def set_hire_me_page
    @hire_me_page = @site.setting_hire_mes.first
    @hero_image_url   = url_for(@hire_me_page.hero_image)
    @site_general_info = @site.setting_general_infos.first
  end

end
