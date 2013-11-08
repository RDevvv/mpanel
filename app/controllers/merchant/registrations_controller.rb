class Merchant::RegistrationsController < ::Devise::RegistrationsController
  layout 'merchant'
  def new
    super
  end
end