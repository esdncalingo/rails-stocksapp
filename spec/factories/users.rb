FactoryBot.define do
  factory :user do
    email { "daniel@email.com" }
    fname { "daniel" }
    mname { "navarro" }
    lname { "calingo" }
    contacts { "000-0000-0000" }
    address { "Rizal" }
    balance { 0 }
    status { "approved" }
  end
end
