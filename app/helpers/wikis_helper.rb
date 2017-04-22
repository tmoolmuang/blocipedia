module WikisHelper
  def getUser(id)
    #if an author of a wiki is deleted, or no name has been edited
    begin
      if User.find(id).name
        User.find(id).name + ": " + User.find(id).email
      else
        User.find(id).email
      end
    rescue ActiveRecord::RecordNotFound  
      return "an anonymous user"
    end
  end
end
