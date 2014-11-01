require 'sidekiq/web'
SidekiqMailer::Application.routes.draw do

  root :to => "Notifies#index"
  mount Sidekiq::Web => '/sidekiq'

  resources "notifies" do
    collection do
      post "notify/:id", to: "notifies#notify", as: "notify"
    end
  end

end
