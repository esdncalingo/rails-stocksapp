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
  get "/admin/edituser" => "admins#edit_user", as: :edit_user
  post "/activate" => "admins#activate_user", as: :activate_user

  # Users Information


  # Homepage
  get "/home" => "home#index"
  get "/pending" => "home#pending", as: :pending_page
  post "/sample" => "home#sample", as: :sample_page

  # stocks 
  get "/stocks/show" => "stocks#show", as: :stocks_page
  post "/stocks/purchase:stock_code" => "stocks#transact", as: :transact_stocks
  # post "/stocks/purchase" => "stocks#details", as: :stocks_details
  post "/stocks/search" => "stocks#search", as: :search_stocks
end
