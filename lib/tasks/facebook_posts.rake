namespace :shoffr do
  desc 'fetch facebook posts'
  task :facebook_posts => :environment do
    @graph = Koala::Facebook::API.new(Account.first.facebook_access_token)
    Brand.all.each do |brand|
      unless brand.facebook_handle.blank?
        posts = @graph.get_connections(brand.facebook_handle, 'feed')
        posts.each do |post|
          article_id = post['id'].gsub('_', ' ').split.last
          post_url = "https://www.facebook.com/#{brand.facebook_handle}/posts/#{article_id}"
          brand.facebook_posts.create(:post_text => post['message'], :post_url => post_url, :facebook_post_id => post['id'], :image_url => post['picture'])
        end
      end
    end
  end
end
