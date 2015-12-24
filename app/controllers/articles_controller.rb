class ArticlesController < ApplicationController
	before_action :set_order, only: [:show, :edit,:update, :destroy]
	# http_basic_authenticate_with name: 'Kevin', password: '0325', except: [:index, :show]
	def index
		@articles = Article.all
	end

	def show
	end

	def new
		@article = Article.new
	end

	def edit
	end

	def create		
		@article = Article.new(article_params)
		@article.user = current_user
		if @article.save
			flash[:success] = "Successfully cerate a post!"
			redirect_to @article
		else
			render 'new'
		end
	end

	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render 'edit'
		end
	end

	def destroy		
		@article.destroy

		redirect_to articles_path
	end

	private
		def set_order
			@article = Article.find(params[:id])
		end
		
		def article_params
			params.require(:article).permit(:title, :text)
		end
end
