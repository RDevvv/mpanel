require 'resque_web/engine'

module ResqueAdditions
  module Engine

    def self.included(base)
      base.class_eval {

        get '/admin' do
          redirect "/admin"
        end

      }
    end
  end
end

ResqueWeb::Engine.tabs << 'Admin'

ResqueWeb::Engine.class_eval do
  include ResqueAdditions::Engine
end