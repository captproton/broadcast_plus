
# To keep things organized, we put non-authenticated controllers in the `Public::` namespace.
# The root `/` path is routed to `Public::HomeController#index` by default.
get "privacy", to: "legal#privacy"
get "terms", to: "legal#terms"
