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
    @text_number                  = @site.setting_general_infos.first.text_number
    @newsletter_subscription_url  = @site.setting_general_infos.first.newsletter_subscription_url
    # @site_meta_image_url          = _set_site_meta_image_url

    if @site.setting_general_infos.first.is_team_website? == true
      @texting_phrase = "TEXT US"
      @possesive      = "our"
      @objective_case = "us"
      @hiring_phrase  = "Services"
    else
      @texting_phrase = "TEXT ME"
      @possesive      = "my"
      @objective_case = "me"
      @hiring_phrase  = "Hire Me"
    end
  end

  def set_first_time
    @first_time = @site.setting_first_times.first
  end

  def collect_sets_for_the_frontdoor
    @upcoming_events          ||=  @site.events.coming_soon
    @upcoming_meetups         ||=  Event.coming_soon
    @linked_icon_data         ||=  PublisherAccount.all_links_and_icons
    @linked_icons_for_footer  ||= PublisherAccount.linked_icons_for_footer
  end
# 


# Controllers can call this to add classes to the body tag
def add_body_css_class(css_class)
  @body_css_classes ||= []
  @body_css_classes << css_class
end  
  
end
