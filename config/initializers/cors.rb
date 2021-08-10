# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.
# origins 'https://cocky-kare-ad2c13.netlify.app'

# Read more: https://github.com/cyu/rack-cors


Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://cocky-kare-ad2c13.netlify.app'

    resource '*',
             headers: :any,
             expose: ["Authorization"],
             credentials: true,
             methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
