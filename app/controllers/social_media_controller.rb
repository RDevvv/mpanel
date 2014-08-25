class SocialMediaController < ApplicationController
  def facebook_verification
    @params = Hash.new
    @params[:verify_token] = 'asdf'
    Koala::Facebook::RealtimeUpdates.meet_challenge(@params, 'CAACEdEose0cBAI6o8bDZBbIKxcezo8PcZCk0sZBeMZBXpHxdulVvTPUj3QEAEKCMEgHiT0IF05hychkD7jsjEXQnAQpox3RlqpXnIsYOmcPm7wig7YluqTGdkGCfVpzJ5IVghRrtq35yN7xl9u1pCHsruY3UVo1ZA23SCbMCz2wADI5c7EWUkzVutZBOMGlf9iq3mCVPfIET9e5zextkub')
  end
end
