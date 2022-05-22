class Api::V1::PressKitEntriesEndpoint < Api::V1::Root
  helpers do
    params :setting_press_kit_id do
      requires :setting_press_kit_id, type: Integer, allow_blank: false, desc: "Setting Press Kit ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Press Kit Entry ID"
    end

    params :press_kit_entry do
      optional :title, type: String, desc: Api.heading(:title)
      optional :article_link, type: String, desc: Api.heading(:article_link)
      optional :publish_on, type: Date, desc: Api.heading(:publish_on)
      optional :release_at, type: DateTime, desc: Api.heading(:release_at)
      optional :article_image, type: File, desc: Api.heading(:article_image)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "setting_press_kits", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource PressKitEntry
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
    get "/:setting_press_kit_id/press_kit_entries" do
      @paginated_press_kit_entries = paginate @press_kit_entries
      render @paginated_press_kit_entries, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :setting_press_kit_id
      use :press_kit_entry
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:setting_press_kit_id/press_kit_entries" do
      if @press_kit_entry.save
        render @press_kit_entry, serializer: Api.serializer
      else
        record_not_saved @press_kit_entry
      end
    end
  end

  resource "press_kit_entries", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource PressKitEntry
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
        render @press_kit_entry, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :press_kit_entry
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @press_kit_entry.update(declared(params, include_missing: false))
          render @press_kit_entry, serializer: Api.serializer
        else
          record_not_saved @press_kit_entry
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
        render @press_kit_entry.destroy, serializer: Api.serializer
      end
    end
  end
end
