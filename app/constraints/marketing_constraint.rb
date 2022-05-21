class MarketingConstraint
    DOMAIN = ENV["HOSTNAME"].to_s
    SUBDOMAINS = ["www", ""]

    def self.matches?(request)
        return false if request.domain != DOMAIN
        SUBDOMAINS.include? request.subdomain    
    end
end
