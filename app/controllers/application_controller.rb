class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?        #helper_methodをつけるとViewでも使えるようになる

    include Common
    require 'twitter'
    
    def login_required
        if logged_in?
            @current_user = User.find(session[:user_id])
        else
            redirect_to root_path
        end
    end

        private

        #current_userに
        def current_user
            return unless session[:user_id]
            @current_user ||= User.find(session[:user_id])
        end

        #ログイン:true, ログアウト:false
        def logged_in?
            !!session[:user_id]
        end

        def authenticate
            return if logged_in?
            redirect_to root_path, alert: 'ログインしてください'
        end
    
end
