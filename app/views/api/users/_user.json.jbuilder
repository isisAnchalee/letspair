json.extract! @user, :id, :first_name, :last_name, :email

if @user.is_company?
  json.company_profile @user.profile do |profile|
    json.name profile.name
    json.description profile.description
  end
else
  json.user_profile @user.profile do |profile|
    json.short_tag_line profile.short_tag_line
    json.description profile.description
    json.work_history profile.work_history
  end
end

if current_user.follows?(@user)
  follow = Follow.where(follower_id: current_user.id, followee_id: @user.id).first
  json.follow  do
    json.id follow.id
    json.followee_id follow.followee_id
    json.follower_id follow.follower_id
  end
end
