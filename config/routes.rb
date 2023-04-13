Rails.application.routes.draw do
  root "home#index"

  # Session routes
  get "/signin" => "sessions#signin", as: :signin_page
  get "/signup" => "sessions#signup", as: :signup_page
  get "/userinfo" => "sessions#userinfo", as: :userinfo
  post "/signin" => "sessions#new_session", as: :new_session
  post "/signup" => "sessions#new_account", as: :new_account
  post "/userinfo" => "sessions#new_userinfo", as: :new_userinfo
  post "/signout" => "sessions#signout", as: :signout


  # Admin routes
  get "/admin" => "admins#index"

  # Users Information


  # Homepage
  get "/home" => "home#index"
  post "/sample" => "home#sample", as: :sample_page

  # stocks 
  get "/stocks/show" => "stocks#show", as: :stocks_page
  get "/stocks/purchase" => "stocks#purchase", as: :purchase_stocks
  post "/stocks/purchase" => "stocks#details", as: :stocks_details
end
