namespace :shoffr do
  desc 'fetch facebook posts'
  task :facebook_posts => :environment do
    @graph = Koala::Facebook::API.new(Account.first.facebook_access_token)
    Brand.all.each do |brand|
      unless brand.facebook_handle.blank?
        posts = @graph.get_connections(brand.facebook_handle, 'feed')
        posts.each do |post|
          id = post['id']
          brand.facebook_posts.create(:post_text => post['message'], :facebook_post_id => post['id'], :image_url => post['picture'])
        end
      end
    end
  end
end
