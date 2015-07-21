require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


module SetPrep
  class Application < Rails::Application
    RSpotify::authenticate(ENV["SPOTIFY_SET_PREP_ID"], ENV["SPOTIFY_SET_PREP_SECRET"])
  end
end
