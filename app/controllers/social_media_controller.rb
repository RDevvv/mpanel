class SocialMediaController < ApplicationController
  def facebook_verification
    @params = Hash.new
    @params[:verify_token] = 'asdf'
    Koala::Facebook::RealtimeUpdates.meet_challenge(@params, 'asdf')
    render :text => params[:'hub.challenge']
  end
end
