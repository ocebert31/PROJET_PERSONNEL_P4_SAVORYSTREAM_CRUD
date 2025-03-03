# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*' # Permet toutes les origines
      resource '*',
        headers: :any,
        methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  
    # Ou si tu veux restreindre à un frontend spécifique :
    # allow do
    #   origins 'http://ton-frontend-domain.com'
    #   resource '*',
    #     headers: :any,
    #     methods: [:get, :post, :put, :patch, :delete, :options, :head]
    # end
  end
  