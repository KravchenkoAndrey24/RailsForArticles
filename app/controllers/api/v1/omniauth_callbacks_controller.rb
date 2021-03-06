require 'base64'

class Api::V1::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  def omniauth_success
    auth_info = request.env['omniauth.auth']
    user = User.find_by(uid: auth_info.uid, provider: auth_info.provider)
    user_email = User.find_by(email: auth_info.info.email)

    if user_email
      user = user_email
    end

    unless user
      user = User.new
      user.provider = auth_info.provider
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
    secret_ui_token = Base64.encode64(ui_token.to_json)

    redirect_to "https://cocky-kare-ad2c13.netlify.app/login?token=#{secret_ui_token}"
  end

end
