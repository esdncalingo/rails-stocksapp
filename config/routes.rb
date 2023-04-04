Rails.application.routes.draw do
  root "home#index"

  # authentication form
  get "/signin" => "auth#signin", as: :signin_page
  get "/signup" => "auth#signup", as: :signup_page
  post "/signin" => "auth#new_session", as: :new_session
  post "/signup" => "auth#new_account", as: :new_account

  # Homepage
  get "/home" => "home#index"
  post "/sample" => "home#sample", as: :sample_page

  # stocks 
  get "/stocks/show" => "stocks#show", as: :stocks_page
end
