Rails.application.routes.draw do
  #scope :admin do
    devise_for :users,ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    #end
    #scope :member do
    #devise_for :users, ActiveAdmin::Devise.config
    #ActiveAdmin.routes(self)
    #end
    root to: "admin/dashboard#index", as: "welcome"
end
