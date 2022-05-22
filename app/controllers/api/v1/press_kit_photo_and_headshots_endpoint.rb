class Api::V1::PressKitPhotoAndHeadshotsEndpoint < Api::V1::Root
  helpers do
    params :setting_press_kit_id do
      requires :setting_press_kit_id, type: Integer, allow_blank: false, desc: "Setting Press Kit ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Press Kit Photo And Headshot ID"
    end

    params :press_kit_photo_and_headshot do
      optional :title, type: String, desc: Api.heading(:title)
      optional :description, type: String, desc: Api.heading(:description)
      optional :dimensions_wxh, type: String, desc: Api.heading(:dimensions_wxh)
      optional :headshot_or_other, type: String, desc: Api.heading(:headshot_or_other)
      optional :publish_at, type: Date, desc: Api.heading(:publish_at)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "setting_press_kits", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource PressKitPhotoAndHeadshot
    end

    #
    # INDEX
    #

    desc Api.title(:index), &Api.index_desc
    params do
      use :setting_press_kit_id
    end
    oauth2
    paginate per_page: 100
    get "/:setting_press_kit_id/press_kit_photo_and_headshots" do
      @paginated_press_kit_photo_and_headshots = paginate @press_kit_photo_and_headshots
      render @paginated_press_kit_photo_and_headshots, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :setting_press_kit_id
      use :press_kit_photo_and_headshot
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:setting_press_kit_id/press_kit_photo_and_headshots" do
      if @press_kit_photo_and_headshot.save
        render @press_kit_photo_and_headshot, serializer: Api.serializer
      else
        record_not_saved @press_kit_photo_and_headshot
      end
    end
  end

  resource "press_kit_photo_and_headshots", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource PressKitPhotoAndHeadshot
    end

    #
    # SHOW
    #

    desc Api.title(:show), &Api.show_desc
    params do
      use :id
    end
    oauth2
    route_param :id do
      get do
        render @press_kit_photo_and_headshot, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :press_kit_photo_and_headshot
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @press_kit_photo_and_headshot.update(declared(params, include_missing: false))
          render @press_kit_photo_and_headshot, serializer: Api.serializer
        else
          record_not_saved @press_kit_photo_and_headshot
        end
      end
    end

    #
    # DESTROY
    #

    desc Api.title(:destroy), &Api.destroy_desc
    params do
      use :id
    end
    route_setting :api_resource_options, permission: :destroy
    oauth2 "delete"
    route_param :id do
      delete do
        render @press_kit_photo_and_headshot.destroy, serializer: Api.serializer
      end
    end
  end
end
