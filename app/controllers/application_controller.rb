class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :init_blog

  private

    def init_blog
      @blog = THE_BLOG
    end
end
