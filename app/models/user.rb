class User < ApplicationRecord
  # belongs_to :user_type
  # belongs_to :authentication

  def self.signup(params)
    create( fname: params[:fname],
            mname: params[:mname],
            lname: params[:lname],
            email: params[:email],
            contacts: params[:contacts],
            address: params[:address],
            usertype_id: 2,
            auth_id: Authentication.last.id
    ).save
  end

end
