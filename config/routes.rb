Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Authentication endpoints
      post "auth/signup", to: "auth#signup"
      post "auth/signin", to: "auth#signin"
      post "auth/refresh", to: "auth#refresh"
      post "auth/logout",  to: "auth#logout"

      # Athlete resource
      resources :athletes

      # Session metrics by athlete (not nested)
      get "session_metrics/by_athlete/:athlete_id", to: "session_metrics#by_athlete"

      # Training sessions + session_metrics + leaderboard
      resources :training_sessions do
        member do
          get "leaderboard", to: "training_sessions#leaderboard"
        end

        resources :session_metrics
      end
    end
  end
end
