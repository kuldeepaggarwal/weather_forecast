# frozen_string_literal: true

Rails.application.routes.draw do
  get '/weather_search', controller: :weathers, action: :search
  post '/weather_search', controller: :weathers, action: :search
  root to: 'weathers#index'
end
