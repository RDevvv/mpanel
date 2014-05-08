require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://m.shoffr.com'
SitemapGenerator::Sitemap.create do
    Area.all.each do |area|
        add "/deals/outlets?location=#{area.area_name}&search=all&latitude=00&longitude=00&view=outlet_view", :changefreq => 'daily', :priority => 0.9
    end
    ButtonClick.all.uniq{|bc|bc.current_link}.each do |bc|
        if bc.length > 10
            add bc, :changefreq => 'daily', :priority => 0.9
        end
    end
end
