Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :teachers, only: [:index, :show, :create, :update, :destroy]
      resources :students, only: [:index, :show, :create, :update, :destroy] do
        member do
          post 'add_section/:section_id', to: 'students#add_section'
          delete 'remove_section/:section_id', to: 'students#remove_section'
          get 'schedule', to: 'students#schedule_pdf'
        end
      end
      resources :classrooms, only: [:index, :show, :create, :update, :destroy]
      resources :subjects, only: [:index, :show, :create, :update, :destroy]
      resources :sections, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
