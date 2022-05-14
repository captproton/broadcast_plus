class Public::CustomerSite::BaseController < Public::ApplicationController
  before_action :set_site

  def set_site
    if request.domain == MarketingConstraint::DOMAIN
      @site = Site.find_by!(subdomain: request.subdomain)
    else
      @site = Site.find_by(domain: request.domain)
    end
  rescue ActiveRecord::RecordNotFound
    render json: { message: "Site does not exist" }
  end

  def index
    
  end
  
end
