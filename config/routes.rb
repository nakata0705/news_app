Rails.application.routes.draw do
  root :to                  => 'article#view'
  get 'article/view/:lang'  => 'article#view'

  get 'source/view'         => 'source#view'
  get 'source/:id/update'   => 'source#update'
  get 'source/update'       => 'source#update_all'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
