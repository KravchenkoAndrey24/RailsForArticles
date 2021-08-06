class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
                def index
                end
end
