class Api::V1::Root < Api::Base
  include Api::V1::Base

  mount Api::V1::SitesEndpoint
  mount Api::V1::WallpapersEndpoint
  mount Api::V1::BooksEndpoint
  mount Api::V1::EventsEndpoint
  mount Api::V1::MediaAppearancesEndpoint
  mount Api::V1::MerchandiseLinksEndpoint
  # 🚅 super scaffolding will mount new endpoints above this line.

  handle_not_found
end
