require 'test_helper'

class NestedCommentsControllerTest < ActionController::TestCase
  setup do
    @nested_comment = nested_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:nested_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nested_comment" do
    assert_difference('NestedComment.count') do
      post :create, nested_comment: { comment_id: @nested_comment.comment_id, parent_id: @nested_comment.parent_id }
    end

    assert_redirected_to nested_comment_path(assigns(:nested_comment))
  end

  test "should show nested_comment" do
    get :show, id: @nested_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nested_comment
    assert_response :success
  end

  test "should update nested_comment" do
    put :update, id: @nested_comment, nested_comment: { comment_id: @nested_comment.comment_id, parent_id: @nested_comment.parent_id }
    assert_redirected_to nested_comment_path(assigns(:nested_comment))
  end

  test "should destroy nested_comment" do
    assert_difference('NestedComment.count', -1) do
      delete :destroy, id: @nested_comment
    end

    assert_redirected_to nested_comments_path
  end
end
