module MessagesHelper

  def user_name id
    user = User.find_by_id(id)
    user.name
  end

end
