set :environment, "production"

set :output, "cron_log.log"

every :day, :at => '12.00 am' do
  rake "data_update:brand_score"
end

every :hour do
    rake 'shoffr:facebook_posts'
end

every :hour do
    rake 'shoffr:tweets'
end

every :day, :at => '12.00 am' do
  rake "sitemap:refresh CONFIG_FILE='config/sitemap.rb'"
end

every :day, :at => '12.00 am' do
  rake "sitemap:refresh CONFIG_FILE='config/m_sitemap.rb'"
end
