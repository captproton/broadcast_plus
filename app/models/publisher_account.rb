class PublisherAccount < ApplicationRecord
  # 🚅 add concerns above.

  belongs_to :site
  # 🚅 add belongs_to associations above.

  # 🚅 add has_many associations above.

  has_one :team, through: :site
  # 🚅 add has_one associations above.

  # 🚅 add scopes above.

  validates :name, presence: true
  # 🚅 add validations above.

  # 🚅 add callbacks above.

  # 🚅 add delegations above.

    scope :published_to,    -> { where("podcast_ranking > ?", 0).order("podcast_ranking DESC")}
    # scope :sorted_by_network_kind_n_name, -> { order('network_kind DESC', :name) }
    scope :social_accts,    -> { where("network_kind = ?", 'social').order(:name) }
    scope :podcast_accts,    -> { where("network_kind = ?", 'podcast').order(:name) }

    def self.link(account_name)
        url = self.find_by(name: account_name).url
    end

    def self.all_links_and_icons
        accounts = PublisherAccount.where("linked_icon_for_footer = ?", true)
            .order(:frontpage_ranking)
            .select(:name, :url, :font_awesome_class, :network_kind, :blurb)
    end

    def self.frontpage_icons(site)
        accounts = site.publisher_accounts.where("frontpage_ranking > ?", 0)
            .order(:frontpage_ranking)
            .select(:name, :url, :font_awesome_class, :network_kind, :blurb)
    end

    def self.sidebar_icons(site)
        accounts = site.publisher_accounts.where("sidebar_ranking > ?", 0)
            .order(:sidebar_ranking).
            select(:name, :url, :font_awesome_class, :network_kind)
    end

    def self.footer_icons
        accounts = self.where("footer_ranking > ?", 0)
            .order(:footer_ranking)
    end

    def self.linked_icons_for_footer
        accounts = self.footer_icons
            .select(:name, :url, :font_awesome_class, :network_kind, :blurb)
    end

    def self.sorted_by_network_kind_n_name
        order('network_kind DESC', :name)
    end

    def self.palooza
        "love"
    end

    def self.index_social_accounts
        where("network_kind = ?", 'social').order(:name).select(:id, :name, :font_awesome_class, :network_kind, :blurb)
    end

    def self.index_podcast_accounts
        where("network_kind = ?", 'podcast').order(:name).select(:id, :name, :font_awesome_class, :network_kind, :blurb)
    end
  # 🚅 add methods above.

end
