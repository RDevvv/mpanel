require 'test_helper'

class CustomerFeedbacksControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
        @customer_feedback = customer_feedbacks(:one)
    end

    test "should get index" do
        get :index
        assert_response :success
        assert_not_nil assigns(:customer_feedbacks)
    end

    test "should get new" do
        get :new
        assert_response :success
    end

    test "should create customer_feedback" do
        assert_difference('CustomerFeedback.count') do
            post :create, customer_feedback: { email: @customer_feedback.email, feedback: @customer_feedback.feedback, link: '/outlet_listing?location=bandra'}
        end

        assert_redirected_to customer_feedback_path(assigns(:customer_feedback))
    end
end
