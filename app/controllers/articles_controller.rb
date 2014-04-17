class ArticlesController < ApplicationController
    respond_to :html, :json

    def index
        @articles = Article.all

        respond_with @articles
    end

    def show
        @article = Article.find(params[:id])
        @commentable = @article
        @article_comments = @commentable.article_comments
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
