class Public::FirstTimeHereController < Public::CustomerSite::BaseController
  before_action :set_page_info
  before_action :set_video_info
  layout "frontdoor"

  # GET /first_time_here
  def show
    @sidebar_icons              = PublisherAccount.sidebar_icons(@site).first(5)
    # what your should read first
    @blog_list_title        = "first-time-here-bottom"
    @recommended_entries    = BlogEntry.recommend_entries(@site, @blog_list_title)

  end


  def set_page_info
    @page_info = @site.setting_first_times.first
    @hero_image_url   = url_for(@page_info.hero_image)
    @site_general_info = @site.setting_general_infos.first
  end

  def set_video_info
    @featured_youtube_video_url   = @page_info.featured_youtube_video_url
    @youtube_video_id             = @featured_youtube_video_url.to_s.split('v=').last 
    @featured_youtube_image_url   = "https://i.ytimg.com/vi/#{@youtube_video_id}/maxresdefault.jpg"
    
    if !@youtube_video_id.to_s.length == 11
      @featured_youtube_image_url   = "https://via.placeholder.com/727x384.png?text=Featured+YouTube+Video"
    end    
  end

end
