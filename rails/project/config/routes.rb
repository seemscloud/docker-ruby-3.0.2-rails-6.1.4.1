Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  require 'sidekiq_unique_jobs/web'

  Sidekiq::Web.app_url = '/">Back to application</a><a style="display:none'
  mount Sidekiq::Web => '/sidekiq' #, constraints: lambda {|request| request.session[:id] == 1}
end
