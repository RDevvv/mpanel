namespace :shoffr do
  desc 'fetch facebook counts'
  task :facebook_counts => :environment do
    @graph = Koala::Facebook::API.new(Account.first.facebook_access_token)
    FacebookPost.all.each do |fp|
      sharing_data = @graph.fql_query("SELECT like_info.like_count, comment_info.comment_count FROM stream WHERE post_id = \'#{fp.facebook_post_id}\'").first
      fp.update_attributes(:likes => sharing_data['like_info']['like_count'], :comments => sharing_data['comment_info']['comment_count'])
    end
  end
end
