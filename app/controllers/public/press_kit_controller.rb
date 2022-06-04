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

    @press_kit              = @site.setting_press_kits.first
    @press_kit_entries      = @press_kit.press_kit_entries.all
    @press_kit_photos       = @press_kit.press_kit_photo_and_headshots.all
    @press_kit_headshots    = @press_kit.press_kit_photo_and_headshots.published_headshots
    @press_kit_actionshots  = @press_kit.press_kit_photo_and_headshots.published_action_shots
    @social_links           = @press_kit.press_kit_links.social
    @website_links          = @press_kit.press_kit_links.website
    @company_links          = @press_kit.press_kit_links.company
  end

end
