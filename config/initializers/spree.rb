Spree.config do |config|
  config.allow_ssl_in_production = false
  config.logo = 'logo.jpg'
end

Spree.user_class = "Spree::User"
