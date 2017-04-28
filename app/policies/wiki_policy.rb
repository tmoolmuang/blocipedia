class WikiPolicy < ApplicationPolicy
  def index?
    true
  end
  
  def show?
    true
  end
  
  def new?
    user
  end
  
  def create?
    user
  end

  def edit?
    user                             # must login
  end
  
  def update?
    user
  end
  
  def destroy?
    user.id == record.user_id         # must be wiki owner???
  end
  
  def mywikis?
    user
  end
  
  class Scope
    attr_reader :user, :scope
 
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
 
    def resolve
      wikis = []
      collaborators = []

      if user.role == 'admin'
        wikis = scope.all # if the user is an admin, show them all the wikis
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          wiki.collaborators.each do |collaborator|
            collaborators << collaborator.email
          end
          if wiki.private == false || wiki.user == user || collaborators.include?(user.email)
            wikis << wiki
          end
        end
      else # this is the lowly standard user
        all_wikis = scope.all
        all_wikis.each do |wiki|
          wiki.collaborators.each do |collaborator|
            collaborators << collaborator.email
          end
          if wiki.private == false || collaborators.include?(user.email)
            wikis << wiki
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end
  
end
