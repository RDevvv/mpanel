class SocialMediaController < ApplicationController
  def facebook_posts
    Koala::Facebook::RealtimeUpdates.meet_challenge(params, Account.first.facebook_access_token)
  end
end
