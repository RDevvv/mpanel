class Merchant::SessionsController < ::Devise::SessionsController
  layout 'merchant'
   def new
    super
  end

end