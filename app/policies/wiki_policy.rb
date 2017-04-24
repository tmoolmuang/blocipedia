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
  
end
