class MarketingConstraint
    DOMAIN = "lvh.me"
    SUBDOMAINS = ["www", ""]

    def self.matches?(request)
        return false if request.domain != DOMAIN
        SUBDOMAINS.include? request.subdomain    
    end
end
