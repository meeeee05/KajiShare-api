Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:3001'  # Next.js のURLを許可

    resource '*',
      headers: :any,
      expose: ['access-token', 'client', 'uid'],  # トークンをフロント側で受け取る
            methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end