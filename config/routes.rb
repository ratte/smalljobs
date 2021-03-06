require 'main_subdomain'
require 'region_subdomain'
require 'api_subdomain'

Smalljobs::Application.routes.draw do
  mount Rich::Engine => '/rich', :as => 'rich'
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :brokers, only: :confirmations, controllers: {
    confirmations: 'confirmations'
  }

  devise_for :providers, only: :confirmation, controllers: {
    confirmations: 'confirmations'
  }

  devise_for :seekers, only: :confirmation, controllers: {
    confirmations: 'confirmations'
  }

  get 'about_us',         to: 'pages#about_us'
  get 'privacy_policy',   to: 'pages#privacy_policy'
  get 'terms_of_service', to: 'pages#terms_of_service'
  get 'features',         to: 'pages#features'
  get 'join_us',          to: 'pages#join_us'
  get 'rules_of_action',  to: 'pages#rules_of_action'
  get 'app_links',        to: 'pages#app_links'

  constraints(RegionSubdomain) do
    devise_for :brokers, except: :confirmation, controllers: {
      registrations: 'registrations',
      sessions: 'sessions',
      passwords: 'passwords'
    }

    devise_for :providers, except: :confirmation, controllers: {
      registrations: 'registrations',
      sessions: 'sessions',
      passwords: 'passwords'
    }

    devise_for :seekers, except: :confirmation, controllers: {
      registrations: 'registrations',
      sessions: 'sessions'
    }

    get 'sign_in', to: 'pages#sign_in'
    get 'sign_up', to: 'pages#sign_up'
    get 'global_sign_in', to: 'pages#sign_in'
    post 'context_help', to: 'pages#context_help'

    namespace :broker do
      resource :dashboard, only: :show do
        member do
          post 'save_settings'
        end
      end

      resource :organization, only: [:edit, :update]

      resources :providers do
        member do
          get 'contract'
          delete 'delete'
          post 'add_comment'
          post 'remove_comment'
        end
      end

      resources :seekers do
        member do
          get 'agreement'
          delete 'delete'
          post 'send_message'
          post 'add_comment'
          post 'remove_comment'
        end
      end

      resources :jobs do
        member do
          post 'activate'
          delete 'delete'
          post 'add_comment'
          post 'remove_comment'
        end

        resources :allocations do
          member do
            get 'change_state'
            get 'cancel_state'
            post 'send_message'
          end
        end
      end
    end

    namespace :provider do
      resource :dashboard, only: :show do
        member do
          get 'contract'
        end
      end

      resources :jobs do
        resources :allocations, only: [:index, :show]
      end
    end

    namespace :seeker do
      resource :dashboard, only: :show

      resources :jobs, only: [:index, :show] do
        resources :allocations
      end
    end

    resources :jobs, only: :show

    get '/' => 'regions#show'
  end

  constraints(ApiSubdomain) do
    post '/users/login' => 'api#login'
    get '/users/logout' => 'api#logout'
    post '/users/register' => 'api#register'
    get '/users' => 'api#list_users'
    get '/users/:id' => 'api#show_user'
    patch '/users/:id' => 'api#update_user'
    get '/market/regions' => 'api#list_regions'
    get '/market/regions/:id' => 'api#show_region'
    get '/market/organizations' => 'api#list_organizations'
    get '/market/organizations/:id' => 'api#show_organization'
    get '/jobs' => 'api#list_jobs'
    post '/jobs/apply' => 'api#apply'
    post '/jobs/revoke' => 'api#revoke'
    # get '/jobs/my' => 'api#list_my_jobs'
    get '/jobs/:id' => 'api#show_job'
    get '/allocations' => 'api#list_my_jobs'
    post '/assignments' => 'api#create_assignment'
    patch '/assignments/:id' => 'api#update_assignment'
    delete '/assignments/:id' => 'api#delete_assignment'
    get '/assignments' => 'api#list_assignments'
    get '/assignments/:id' => 'api#show_assignment'
    post '/users/password/remind' => 'api#password_remind'
    post '/users/password/validate' => 'api#password_validate'
    post '/users/password/change' => 'api#password_change'
    put '/messages/update' => 'api#update_messages'
  end

  #API
  post '/api/users/login' => 'api#login'
  get '/api/users/logout' => 'api#logout'
  post '/api/users/register' => 'api#register'
  get '/api/users' => 'api#list_users'
  get '/api/users/:id' => 'api#show_user'
  patch '/api/users/:id' => 'api#update_user'
  get '/api/market/regions' => 'api#list_regions'
  get '/api/market/regions/:id' => 'api#show_region'
  get '/api/market/organizations' => 'api#list_organizations'
  get '/api/market/organizations/:id' => 'api#show_organization'
  get '/api/jobs' => 'api#list_jobs'
  post '/api/jobs/apply' => 'api#apply'
  post '/api/jobs/revoke' => 'api#revoke'
  # get '/api/jobs/my' => 'api#list_my_jobs'
  get '/api/jobs/:id' => 'api#show_job'
  get '/api/allocations' => 'api#list_my_jobs'
  post '/api/assignments' => 'api#create_assignment'
  patch '/api/assignments/:id' => 'api#update_assignment'
  delete '/api/assignments/:id' => 'api#delete_assignment'
  get '/api/assignments' => 'api#list_assignments'
  get '/api/assignments/:id' => 'api#show_assignment'
  post '/api/users/password/remind' => 'api#password_remind'
  post '/api/users/password/validate' => 'api#password_validate'
  post '/api/users/password/change' => 'api#password_change'
  put '/api/messages/update' => 'api#update_messages'

  root 'regions#index'
end
