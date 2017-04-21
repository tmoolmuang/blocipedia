module WikisHelper
  def getUser(id)
    User.find(id).email if id
  end
end
