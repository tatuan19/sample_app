module UsersHelper
  def gravatar_for user, size = Settings.avatar.size.profile
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end

  def current_user_followed
    current_user.active_relationships.find_by followed_id: @user.id
  end
end
