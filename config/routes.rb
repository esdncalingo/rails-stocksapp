Rails.application.routes.draw do
  root "traders#index"

  # Session routes
  get "/signin" => "sessions#signin", as: :signin_page
  get "/signup" => "sessions#signup", as: :signup_page
  get "/userinfo" => "sessions#userinfo", as: :userinfo
  post "/signin" => "sessions#new_session", as: :new_session
  post "/signup" => "sessions#new_account", as: :new_account
  post "/userinfo" => "sessions#new_userinfo", as: :new_userinfo
  post "/signout" => "sessions#signout", as: :signout

  # Admin Dashboard
  get "/admin" => "admins#index"
  # --Pages
  post "/admin" => "admins#homepage"
  post "/admin/userpage" => "admins#userpage"
  # --- Users
  post "/admin/user" => "admins#edit_user", as: :edit_user
  patch "/admin/user" => "admins#update_user", as: :update_user
  post "/admin/user/show" => "admins#show_user"
  post "/admin/user/new" => "admins#new_user", as: :new_user
  post "/admin/user/create" => "admins#create_user", as: :create_user
  post "/admin/user/activate" => "admins#activate_user", as: :activate_user
  post "/admin/user/search" => "admins#search_user"
  # ---- Users View
  post "/admin/user/waiting" => "admins#waiting_list"
  post "/admin/user/active" => "admins#active_users"
  post "/admin/user/filter_order" => "admins#filter_order"

  # Trader Homepage
  get "/home" => "traders#index"
  get "/pending" => "traders#pending", as: :pending_page
  # -- Pages
  get "/deposit" => "traders#deposit"
  get "/buy-sell" => "traders#buysell"
  get "/market" => "traders#market"
  get "/profile" => "traders#profile"
  get "/transaction" => "traders#transaction"
  # --- btn actions
  post "/deposit/addbalance" => "traders#add_balance"
  post "/buy-sell" => "traders#user_buysell"
  post "/transaction" => "traders#filter_transaction"

end
