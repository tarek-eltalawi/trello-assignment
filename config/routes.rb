Rails.application.routes.draw do

  

  get 'profile/show'
  post '/search/show', to: 'search#show'

  get 'home/index'

  get '/projects/add_user', to: 'projects#add_user'
  post '/stories/todo.:format', to: 'stories#todo.js'
  post '/stories/doing.:format', to: 'stories#doing.js'
  post '/stories/done.:format', to: 'stories#done.js'
  post '/tasks/taskstate', to: 'tasks#taskstate'
  post '/search/show', to: 'search#show'

  resources :projects do
    collection do
      post :add_user
    end

    member do
      post :add_user
    end

    resources :stories do
      
      collection do
        post :todo
      end
      member do
        post :todo
      end

      collection do
        post :doing
      end
      member do
        post :doing
      end

      collection do
        post :done
      end
      member do
        post :done
      end

      resources :tasks do
       
        collection do
          post :taskstate
        end
        member do
          post :taskstate
        end
      end
    end

  end

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
