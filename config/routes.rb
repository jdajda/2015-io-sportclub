Rails.application.routes.draw do
  get 'calendar/index'

  resources :courses do
    resources :course_events, path: 'events' do
      resources :course_days, path: 'days'
    end
  end

  resources :items
  resources :events do
  	resources :event_days
  end
  
  root 'events#index'

  get 'sessions/new'

  resources :users
  resources :session

get 'calendar', to: 'calendar#show'

  get 'courses/:id/sign', to: 'courses#sign'
  get 'courses/:course_id/events/:course_event_id/days/:id/sign', to: 'course_days#sign'


end
