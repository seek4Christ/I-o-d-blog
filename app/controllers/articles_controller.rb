class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @current_time = Time.now.to_s
    ActionCable.server.broadcast 'clock_channel', message: '<p>'+Time.now.to_s+'</p>'
    @search = Article.search(params[:q])
    @articles = @search.result(distinct: true)
    @articles = Article.all.paginate(page: params[:page], per_page: 4)
    .order('created_at DESC')
    respond_to do |format|
    format.html
    format.js
    format.rss { render :layout => false }
   end
end

  def about
  end

  def contact
  end

  def show
    @article = Article.find(params[:id])
    @hash = Gmaps4rails.build_markers(@articles) do |article, marker|
    marker.lat article.latitude
    marker.lng article.longitude
    marker.infowindow article.address
    end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
     respond_to do |format|
    if @article.save
      format.html { redirect_to @article, notice: t('article.flash messages.Article was successfully created.') }
        format.json { render :show, status: :created, location: @article}
    else
      format.html { render :new }
      format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @article = Article.find(params[:id])
     respond_to do |format|
    if @article.update(article_params)
      format.html { redirect_to @article, notice: t('article.flash messages.Article was successfully updated.') }
        format.json { render :show, status: :ok, location: @article }

    else
      format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    respond_to do |format|
    format.html { redirect_to articles_path, notice: t('article.flash messages.Article was successfully destroyed.') }
    format.json { head :no_content }
  end
end


   private
    def article_params
    params.require(:article).permit(:title, :text, :tag_list, :image,:lat, :lng )
  end
end
