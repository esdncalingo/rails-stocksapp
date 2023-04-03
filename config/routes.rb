Rails.application.routes.draw do
  root :to => "home#index"

  # authentication form
  get "/signin" => "auth#signin", as: :signin_page
  get "/signup" => "auth#signup", as: :signup_page
  post "/signin" => "auth#new_session", as: :new_session
  post "/signup" => "auth#new_account", as: :new_account

  # WIP for auth
  post "/signup/info" => "auth#signup_next", as: :signup_nextpage

  post "/sample" => "home#sample", as: :sample_page
end
