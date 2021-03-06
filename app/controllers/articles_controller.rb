class ArticlesController < ApplicationController
    layout 'blog'
    respond_to :html, :json

    def index
        @articles = Article.order.all.reverse

        respond_with @articles
    end

    def show
        blog_url = params[:blog_url]
        @article = Article.where(:blog_url => blog_url).first
        @article_comments = @article.article_comments
        @article_comment = ArticleComment.new
        respond_with @article
    end

    def new
        @article = Article.new

        respond_with @article
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(params[:article])

        @article.save
        respond_with @article, :location => articles_path
    end

    def update
        @article = Article.find(params[:id])

        @article.update_attributes(params[:article])
        respond_with @article, :location => articles_path
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy

        respond_with @article
    end
end
