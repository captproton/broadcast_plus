class Public::HomeController < Public::ApplicationController
  # Redirect `/` to either `ENV["MARKETING_SITE_URL"]` or the sign-in page.
  # If you'd like to customize the action for `/`, you can remove this and define `def index ... end ` below.
  # include RootRedirect

  # Allow your application to disable public sign-ups and be invitation only.
  # include InviteOnlySupport

  # Make Bullet Train's documentation available at `/docs`.
  # include DocumentationSupport

  def index
    @site                   = Site.find_by!(subdomain: request.subdomain)


  end

  def privacy

  end
end
