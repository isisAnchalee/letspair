FactoryGirl.define do
  factory :user_profile, class: UserProfile do
    user_id 1
  end

  factory :company_profile, class: CompanyProfile do
    user_id 1
    name "company name"
    description "company description"
  end
end
