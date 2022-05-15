class Public::CustomerSite::BaseController < Public::ApplicationController
  before_action :set_site
  before_action :set_general_info
  before_action :set_first_time
  before_action :collect_sets_for_the_frontdoor

  def index
    
  end

  def set_site
    if request.domain == MarketingConstraint::DOMAIN
      @site = Site.find_by!(subdomain: request.subdomain)
    else
      @site = Site.find_by(domain: request.domain)
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Site does not exist" }
  end

  def set_general_info
    @general_info = @site.setting_general_infos.first if @site
  end

  def set_first_time
    @first_time = @site.setting_first_times.first
  end

  def collect_sets_for_the_frontdoor
    @upcoming_events         ||=  @site.events.coming_soon
    @linked_icon_data         ||=  PublisherAccount.all_links_and_icons
    @linked_icons_for_footer  ||= PublisherAccount.linked_icons_for_footer
  end

  
  
end
