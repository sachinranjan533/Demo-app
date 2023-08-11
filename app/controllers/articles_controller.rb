class ArticlesController < ApplicationController
  
	def index
    
	end	

	def new
    @article = Article.new
    @header = 'New Article'
    respond_to do |format|
      format.js
    end
  end

  def create
    @article = Article.new(article_params)
    respond_to do |format|
      @article.save
      format.js { render :file => "articles/create.js.erb", locals: {:message => "New Article Created Successfully"}}
    end
  end

def show_articles
    respond_to do |format|
      format.html
      format.js { render json: ArticleDatatable.new(view_context)}
    end
  end

  def edit
    @article = Article.find(params[:id])
    @header = 'Edit Article'
    respond_to do |format|
      format.js { render :file => "articles/new.js.erb" }
    end
  end

  def update
  	@article = Article.find(params[:id])
  	respond_to do |format|
			@article.update(article_params)
			format.js { render :file => "articles/create.js.erb",locals: {:message => "Article Updated Successfully" }}
    end		
  end	

  def destroy
    @article = Article.find(params[:id])
  	respond_to do |format|
			@article.destroy
			format.js { render :file => "articles/destroy.js.erb", locals: {:message => "Article deleted Successfully" }}
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
