Rails.application.routes.draw do

  root to: redirect('/session/sign_in')

  resource :session, only: [:new, :create, :destroy],
                     path_names: { new: 'sign_in' }

  resources :clients, param: :dni, only: [:edit, :create, :update, :new] do
    resources :visits, only: [:new]
  end

  resources :visits, only: [:create]

  resources :turns
end
