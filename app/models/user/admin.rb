class User
  class Admin
    def self.user_list(list_type)
      case list_type
      when "userpage"
        @user = User.order(created_at: :desc)
      when "waiting_list"
        @user = User.order(created_at: :desc).where(status: "pending")
      when "active_users"
        @user = User.joins(:authentication).where( authentication: { is_active: true })
      end
    end
  end
end