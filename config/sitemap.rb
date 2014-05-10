require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'http://www.shoffr.com'
SitemapGenerator::Sitemap.sitemaps_path = "sitemaps/desktop"
SitemapGenerator::Sitemap.create do

  Article.all.each do |article|
    add "/articles/#{article.blog_url}", :changefreq => 'never', :priority => 0.9
  end

end
