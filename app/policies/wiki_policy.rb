class WikiPolicy < ApplicationPolicy
  # def index?
  #   true
  # end
  
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
    user.id == record.user_id or user.admin?        # must be wiki owner or admin
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
      
      # not login, show only public wikis
      if user.nil?
        all_wikis = scope.all
        all_wikis.each do |wiki|
          wikis << wiki unless wiki.private
        end
      # admin, show all   
      elsif user.role == 'admin'
        wikis = scope.all 
      # premium, show all public, show own private, show collaborate  
      elsif user.role == 'premium'
        all_wikis = scope.all
        all_wikis.each do |wiki|
          collaborators = []
          wiki.collaborators.each do |collaborator|
            collaborators << collaborator.email
          end
          if !wiki.private? || wiki.user == user || collaborators.include?(user.email)
            wikis << wiki
          end
        end
      # standard, show all public, show collaborate
      else 
        all_wikis = scope.all
        all_wikis.each do |wiki|
          collaborators = []
          wiki.collaborators.each do |collaborator|
            collaborators << collaborator.email
          end
          if !wiki.private? || collaborators.include?(user.email)
            wikis << wiki
          end
        end
      end  
      wikis # return the wikis array we've built up
    end
  end
  
end
