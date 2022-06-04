class CustomerSiteConstraint
    RESERVED_SUBDOMAINS = ['help','support','developer','dev']
    def self.matches?(request)
        return true if request.domain != MarketingConstant::DOMAIN

        (RESERVED_SUBDOMAINS + MarketingConstant::SUBDOMAINS).exclude? request.subdomain
    end
end
