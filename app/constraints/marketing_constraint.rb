class MarketingConstraint
    DOMAIN = "mybroadcast.xyz"
    SUBDOMAINS = ["www", ""]

    def self.matches?(request)
        return false if request.domain != DOMAIN
        SUBDOMAINS.include? request.subdomain    
    end
end
