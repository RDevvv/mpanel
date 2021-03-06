class Keyword < ActiveRecord::Base

    attr_accessible :ad_ids, :keyword, :keyword_alias,:attachments_attributes
    has_many :ad_keywords, :dependent => :destroy
    has_many :ads, :through => :ad_keywords
    has_many :customer_keywords
    has_many :customers, :through => :customer_keywords

    has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
    accepts_nested_attributes_for :attachments ,allow_destroy: true

    validates_uniqueness_of :keyword, :message => " Oops...This keyword already exists."

    def self.search(term)
        result = Keyword.where("LOWER(keyword) ilike '%#{term.downcase}%'").includes(:ad_keywords => :ad)
        unless result.blank?
            final_result = result.map{|keyword|keyword.ad_keywords}.flatten.map{|ak| ak.ad}
        end
        final_result
    end
end
