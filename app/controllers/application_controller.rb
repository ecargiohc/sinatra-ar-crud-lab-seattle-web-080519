
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # set :method_override, true
  end

  get '/' do
    redirect to "/articles"
  end

  get '/articles' do #READ ALL
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do #CREATE
    @article = Article.new
    erb :new
  end

  post '/articles' do #CREATE
    # @article = Article.create(params)
    @article = Article.create(:title => params[:title], :content => params[:content])
    redirect to "/articles/#{@article.id}"
    # erb :new
  end

  get '/articles/:id' do #READ SPECIFIC
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  patch '/articles/:id' do
    # @article.update(params[:article])
    @article = Article.find_by_id(params[:id])
    @article.title = params[:title]
		@article.content = params[:content]
		@article.save
		redirect "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    @article.destroy
    redirect '/articles'
  end

end
