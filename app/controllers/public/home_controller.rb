class Public::HomeController < Public::CustomerSite::BaseController
  before_action :set_page_info
  before_action :set_video_info
  layout "frontdoor"

  # GET /
  def index
    # @ = @site.events
    @home_info        = @site.setting_home_infos.first
    @contact_message  = @site.contact_messages.new

  end

  def set_page_info
    @page_info          = @site.setting_home_infos.first
    @home_info          = @page_info
    @frontpage_icons    = PublisherAccount.frontpage_icons(@site)    
    @site_general_info  = @site.setting_general_infos.first
  end

  def set_video_info
    @featured_youtube_video_url   = @page_info.watch_this_video_url
    @youtube_video_id             = @featured_youtube_video_url.to_s.split('v=').last 
    @featured_youtube_image_url   = "https://i.ytimg.com/vi/#{@youtube_video_id}/maxresdefault.jpg"
    
    if !@youtube_video_id.to_s.length == 11
      @featured_youtube_image_url   = "https://via.placeholder.com/727x384.png?text=Featured+YouTube+Video"
    end    
  end

end
