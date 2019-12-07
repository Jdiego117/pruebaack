Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/getOrders', to: 'v1/orders#getAll'
  post '/createOrder', to: 'v1/orders#create'
  post '/changeOrderStatus', to: 'v1/orders#changeState'

  post '/createClient', to: 'v1/clients#create'
  get '/getClients', to: 'v1/clients#getAll'

end
