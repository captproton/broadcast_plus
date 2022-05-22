class Api::V1::Root < Api::Base
  include Api::V1::Base

  mount Api::V1::SitesEndpoint
  mount Api::V1::WallpapersEndpoint
  mount Api::V1::BooksEndpoint
  mount Api::V1::EventsEndpoint
  mount Api::V1::MediaAppearancesEndpoint
  mount Api::V1::MerchandiseLinksEndpoint
  mount Api::V1::PublisherAccountsEndpoint
  mount Api::V1::ImagesEndpoint
  mount Api::V1::BiographiesEndpoint
  mount Api::V1::BlogEntriesEndpoint
  mount Api::V1::BlogArticlesEndpoint
  mount Api::V1::BlogListsEndpoint
  mount Api::V1::SettingBiographiesEndpoint
  mount Api::V1::SettingBookCollectionPagesEndpoint
  mount Api::V1::SettingGeneralInfosEndpoint
  mount Api::V1::SettingHomeInfosEndpoint
  mount Api::V1::SettingFirstTimesEndpoint
  mount Api::V1::SettingGetInContactContentsEndpoint
  mount Api::V1::SettingHireMesEndpoint
  mount Api::V1::SettingEventPagesEndpoint
  mount Api::V1::SettingPodcastsEndpoint
  mount Api::V1::SettingPressKitsEndpoint
  mount Api::V1::SettingMediaAppearancesPagesEndpoint
  mount Api::V1::SettingPodcastPagesEndpoint
  mount Api::V1::PressKitEntriesEndpoint
  mount Api::V1::PressKitPhotoAndHeadshotsEndpoint
  mount Api::V1::PressKitLinksEndpoint
  # 🚅 super scaffolding will mount new endpoints above this line.

  handle_not_found
end
