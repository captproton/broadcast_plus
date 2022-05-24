class Public::GetInTouchController < Public::CustomerSite::BaseController
  before_action :set_page
  layout "frontdoor"

  # GET /books
  # GET /books.json
  def index
    # @ = @site.events

    @youtube_video_id = @page.youtube_url.to_s.split('/').last 
    
    @featured_youtube_image_url                 = @page.youtube_image_url
    if @featured_youtube_image_url.to_s.length  == 0
      @featured_youtube_image_url   = "https://via.placeholder.com/727x384.png?text=Featured+YouTube+Video"
    end

  end


  def set_page
    @page = @site.setting_get_in_contact_contents.first
    # @hero_image_url   = url_for(@page.hero_image)
    @site_general_info = @site.setting_general_infos.first
  end

end
