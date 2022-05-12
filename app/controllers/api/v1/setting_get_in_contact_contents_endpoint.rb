class Api::V1::SettingGetInContactContentsEndpoint < Api::V1::Root
  helpers do
    params :site_id do
      requires :site_id, type: Integer, allow_blank: false, desc: "Site ID"
    end

    params :id do
      requires :id, type: Integer, allow_blank: false, desc: "Setting Get In Contact Content ID"
    end

    params :setting_get_in_contact_content do
      optional :first_name, type: String, desc: Api.heading(:first_name)
      optional :last_name, type: String, desc: Api.heading(:last_name)
      optional :youtube_url, type: String, desc: Api.heading(:youtube_url)
      optional :youtube_image_url, type: String, desc: Api.heading(:youtube_image_url)
      optional :page_message, type: String, desc: Api.heading(:page_message)
      # 🚅 super scaffolding will insert new fields above this line.
      # 🚅 super scaffolding will insert new arrays above this line.

      # 🚅 super scaffolding will insert processing for new fields above this line.
    end
  end

  resource "sites", desc: Api.title(:collection_actions) do
    after_validation do
      load_and_authorize_api_resource SettingGetInContactContent
    end

    #
    # INDEX
    #

    desc Api.title(:index), &Api.index_desc
    params do
      use :site_id
    end
    oauth2
    paginate per_page: 100
    get "/:site_id/setting_get_in_contact_contents" do
      @paginated_setting_get_in_contact_contents = paginate @setting_get_in_contact_contents
      render @paginated_setting_get_in_contact_contents, serializer: Api.serializer
    end

    #
    # CREATE
    #

    desc Api.title(:create), &Api.create_desc
    params do
      use :site_id
      use :setting_get_in_contact_content
    end
    route_setting :api_resource_options, permission: :create
    oauth2 "write"
    post "/:site_id/setting_get_in_contact_contents" do
      if @setting_get_in_contact_content.save
        render @setting_get_in_contact_content, serializer: Api.serializer
      else
        record_not_saved @setting_get_in_contact_content
      end
    end
  end

  resource "setting_get_in_contact_contents", desc: Api.title(:member_actions) do
    after_validation do
      load_and_authorize_api_resource SettingGetInContactContent
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
        render @setting_get_in_contact_content, serializer: Api.serializer
      end
    end

    #
    # UPDATE
    #

    desc Api.title(:update), &Api.update_desc
    params do
      use :id
      use :setting_get_in_contact_content
    end
    route_setting :api_resource_options, permission: :update
    oauth2 "write"
    route_param :id do
      put do
        if @setting_get_in_contact_content.update(declared(params, include_missing: false))
          render @setting_get_in_contact_content, serializer: Api.serializer
        else
          record_not_saved @setting_get_in_contact_content
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
        render @setting_get_in_contact_content.destroy, serializer: Api.serializer
      end
    end
  end
end
