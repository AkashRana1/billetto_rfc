Rails.application.routes.draw do
  resources :rfcs, only: [:create, :show] do
    resources :approvals, only: :create, controller: "rfc_approvals"
  end

  post "/webhooks/:service", to: "incoming_webhooks#create"
  get "/health", to: "health#show"
end
