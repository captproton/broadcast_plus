class Public::LegalController < Public::CustomerSite::BaseController
  before_action :set_page_info
  layout "frontdoor"

  def privacy
    title = "Privacy Policy"
    @legal_text = LegalText.find_by("title= ?", title)  
  end

  def terms
    title = "Terms of Use"
    @legal_text = LegalText.find_by("title= ?", title)      
  end

  def set_page_info
    @page_info          = @site.setting_home_infos.first
    @site_general_info  = @site.setting_general_infos.first
  end

end
