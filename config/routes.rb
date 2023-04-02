Rails.application.routes.draw do
  root :to => "home#index"

  #authentication form
  get "/signup" => "auth#signup", as: :signup_page
  post "/signup_next" => "auth#signup_next", as: :signup_nextpage

  post "/sample" => "home#sample", as: :sample_page
end
