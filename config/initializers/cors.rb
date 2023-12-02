# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3000' # Adjust the origin to match your frontend's URL
    resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head], expose: ['x-csrf-token']
  end
end
