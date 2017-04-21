module WikisHelper
  def getUser(id)
    #if an author of a wiki is deleted
    begin
      User.find(id).email
    rescue ActiveRecord::RecordNotFound  
      return "an anonymous user"
    end
  end
end
