Rails.application.routes.draw do
  resources :wikis do
    collection do
      get 'mywikis'
    end
  end
  
  devise_for :users
  
  get 'welcome/index'

  get 'welcome/about'
  
  get 'welcome/contact'
  
  root 'welcome#index'
 
end
