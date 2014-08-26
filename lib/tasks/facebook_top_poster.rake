namespace :shoffr do
  desc 'fetch facebook top poster links'
  task :facebook_cover => :environment do
    conn = Faraday.new(:url => 'https://graph.facebook.com/narendramodi') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    data = conn.get do |req|
      req.params['access_token']='478791728847837|6KEyNNrzmu4ZIMp7IwJqbL95LZQ'
    end

    data = JSON.parse(data.body)
    cover_url = data['cover']['source']
    likes_count = data['likes']
  end
end
