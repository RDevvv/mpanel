class CustomerFeedbacksController < ApplicationController
    respond_to :html

    def index
        @customer_feedbacks = CustomerFeedback.all

        respond_with @customer_feedback
    end

    def new
        @customer_feedback = CustomerFeedback.new
        $http_referer = request.env['HTTP_REFERER']
        respond_with @customer_feedback
    end

    def create
        @customer_feedback = Customer.where(:uuid => cookies["customer_uuid"]).first.customer_feedbacks.new(params[:customer_feedback])
        @customer_feedback.link = $http_referer

        @customer_feedback.save
        respond_with @customer_feedback, :location => $http_referer
    end
end
