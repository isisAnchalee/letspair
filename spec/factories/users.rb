# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  admin                  :boolean          default(FALSE)
#  provider               :string
#  uid                    :string
#  first_name             :string           not null
#  last_name              :string           not null
#  is_company             :boolean          not null
#

FactoryGirl.define do
  factory :user do
    first_name "Danneh"
    last_name "Burt"
    email "danneh@danneh.danneh"
    password "hellohello"
    is_company false
    admin false
  end

  factory :company, class: User do
    first_name "Company"
    last_name "A"
    is_company true
    email "A@Company.com"
    password "hellohello"
    admin false
  end
  
  factory :admin, class: User do
    first_name "Admin"
    last_name "Admin"
    is_company false
    admin true
  end
end
