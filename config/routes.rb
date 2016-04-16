Rails.application.routes.draw do

root 'home#index'

get 'routes/find_route'
get 'routes/user_identification'
get 'routes/route_return'
get 'routes/return'
get 'routes/info'
get 'routes/not_interested'
get 'routes/firsttimeslot'
get 'routes/secondtimeslot'
get 'route_suggestions_pledges/pledge_count'
get 'route_suggestions_pledges/pledge_route'
get 'route_suggestions_pledges/pledges'
get 'routes/location'
get 'route_suggestions/generate_otp'
get 'route_suggestions/check_otp'
get 'routes/thankyou'
get 'payment/showPage1' =>"payment#showPage1"
get 'payment/showPage2'=>"payment#showPage2"
get 'clusters/refresh' => "cluster#refreshClusters"
get 'routes/saved' => "route_suggestions_routes#show"
get 'routes/shipped' => "route_suggestions_routes#update"
post 'dashboard/save'
post 'dashboard/shipped'
get 'routes/pledges' => "route_suggestions_routes#pledges"
get 'pledge/list' => "route_suggestions_routes#pledge_list"
post '/pledges/message' => "route_suggestions_routes#message"
get '/points/pledges' => "route_suggestions_routes#live_pledges"
get '/dashboard/locations'
get 'payment/getSignature'=>"payment#createSignature"
get 'cluster/getCluster'=>"cluster#getCluster"
resources :routes, only: [:index,:show]
resources :route_suggestions_pledges, only: [:create]
resources :route_suggestions, only: [:create]
resources :feedbacks, only: [:create]
resources :route_suggestions_customers,only: [:create]
resources :dashboard,only: [:index]
resources :route_exists, only: [:index]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
