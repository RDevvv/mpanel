class CustomerFeedbacksController < ApplicationController
    respond_to :html, :json
    skip_before_filter :verify_authenticity_token, :only => [:create]

    def index
        @customer_feedbacks = CustomerFeedback.all

        respond_with @customer_feedback
    end

    def new
        @customer_feedback = CustomerFeedback.new
        $previous_link = request.env['HTTP_REFERER']
        respond_with @customer_feedback
    end

    def create
        @customer = Customer.where(:uuid => cookies["customer_uuid"]).first
        if @customer.blank?
            @customer_feedback = CustomerFeedback.new(params[:customer_feedback])
        else
            @customer_feedback = @customer.customer_feedbacks.new(params[:customer_feedback])
        end
        @customer_feedback.link = $previous_link
        $previous_link = :root if $previous_link.blank?

        @customer_feedback.save
        respond_with @customer_feedback, :location => $previous_link
    end
end
