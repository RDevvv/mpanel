class CustomerKeywordsController < ApplicationController
    def create
        @customer= Customer.where(:uuid => params[:customer_uuid]).first
        keyword = params[:keyword].gsub('-',' ')
        @keyword = Keyword.where("keyword ilike '%#{keyword}%'").first
        @customer_keywords = CustomerKeyword.new(customer_id: @customer.id, keyword_id: @keyword.id)
        @customer_keywords.save

        render :json => {:nothing => true}
    end
end
