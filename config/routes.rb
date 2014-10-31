SidekiqMailer::Application.routes.draw do

  root :to => "Notifies#index"

  resources "notifies" do
    collection do
      post "notify/:id", to: "notifies#notify", as: "notify"
    end
  end

end
