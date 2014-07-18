require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @article = articles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article" do
    assert_difference('Article.count') do
      post :create, article: { body: @article.body, title: @article.title , page_title: @article.page_title, blog_title: @article.blog_title, blog_category: @article.blog_category, blog_url: @article.blog_url, blog_keywords: @article.blog_keywords, blog_excerpt: @article.blog_excerpt, author: @article.author, blog_body: @article.blog_body, social_share_caption: @article.social_share_caption, image_title: @article.image_title, image_alt_text: @article.image_alt_text, image_caption: @article.image_caption, summary_image_caption: @article.summary_image_caption}
    end

    assert_redirected_to articles_path
  end

  test "should show article" do
    get :show, blog_url: @article.blog_url
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article
    assert_response :success
  end

  test "should update article" do
    put :update, id: @article, article: { body: @article.body, title: @article.title }
    assert_redirected_to articles_path
  end

  test "should destroy article" do
    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end

    assert_redirected_to articles_path
  end
end
