class Api::V1::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  def omniauth_success
    auth_info = request.env['omniauth.auth']
    user = User.find_by(uid: auth_info.uid, provider: 'github')
    unless user
      user = User.new
      user.provider = 'github'
      user.uid = auth_info.uid
      user.email = auth_info.info.email
      user.name = auth_info.info.name
    end
    token = DeviseTokenAuth::TokenFactory.create
    user.tokens[token.client] = {
      token:  token.token_hash,
      expiry: token.expiry
    }
    user.save
    ui_token = {
      'access-token': token.token,
      expiry: token.expiry,
      client: token.client,
      uid: user.uid
    }
    redirect_to "http://localhost:3001/login?token=#{ui_token.to_json}"
  end

end