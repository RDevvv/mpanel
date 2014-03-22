require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://m.gullakmaster.com'
SitemapGenerator::Sitemap.create do
    Area.all.each do |area|
        add "/outlet_listing?location=#{area.area_name}&view=outlet_listing&search=all", :changefreq => 'daily', :priority => 0.9
    end
    ButtonClick.all.uniq{|bc|bc.current_link}.each do |bc|
        if bc.length > 10
            add bc, :changefreq => 'daily', priority: => 0.9
        end
    end
end
