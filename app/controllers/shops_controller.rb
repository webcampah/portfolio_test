class ShopsController < ApplicationController
  require 'uri'

  def show
  	@shop = Shop.find(params[:id])
    @comment = Comment.new
    @user = User.find(params[:id])
  end

  def new
  	@shop = Shop.new
  end

  def create
  	@shop = Shop.new(shop_params)
  	if @shop.save
  		flash[:success] = '新規投稿が成功しました'
  		redirect_to shop_path(@shop.id)
  	else
  		render 'new'
  	end
  end

  def edit
  	@shop = Shop.find(params[:id])
  end

  def update
  	@shop = Shop.find(params[:id])
  	@shop.update(shop_params)
  	if @shop.save
  		flash[:success] = "編集しました"
  		redirect_to shop_path(@shop)
  	else
  		render 'edit'
  	end
  end

  def index
    @q = Shop.search(params[:q])
    @shops = @q.result(distinct: true).page(params[:page]).per(15)
  end

  private

  def shop_params
  	params.require(:shop).permit(:shop_name, :shop_description, :shop_image, :prefecture, :address, :shop_url)
  end
end
