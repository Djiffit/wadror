Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'] = "bf099689aba102f6abec", ENV['GITHUB_SECRET'] = "e1e81a865a1268eaeb5cb02f457bdd6f9635c8b9"
end