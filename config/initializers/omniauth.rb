Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'ef41183c433ff1373fc0', '6382e35d396a5c40e883ed2239f47c982d99ad8b', scope: "user,repo,gist", callback_path: '/api/v1/auth/github/callback'
  provider :google_oauth2, '150387939406-lllmfq0am6f6eff4erssgqo82oi0eai1.apps.googleusercontent.com', 'ogQz3_qTtMEaTCN9ZBJsF9Xi', callback_path: '/api/v1/auth/google_oauth2/callback'
end

OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true
