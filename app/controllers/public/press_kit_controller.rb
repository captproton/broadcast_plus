class Public::PressKitController < Public::CustomerSite::BaseController
  before_action :set_page
  layout "frontdoor"

  # GET /books
  # GET /books.json
  def index
    # @ = @site.events
  end


  def set_page
    @press_kit_page = @site.setting_press_kits.first
    @hero_image_url   = url_for(@press_kit_page.hero_image)
    @site_general_info = @site.setting_general_infos.first
  end

end
