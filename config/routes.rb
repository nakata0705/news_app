Rails.application.routes.draw do
  get 'article/view'      => 'article#view'

  get 'source/view'       => 'source#view'
  get 'source/:id/update' => 'source#update'
  get 'source/update'     => 'source#updateAll'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
